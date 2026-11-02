import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/models/question_model.dart';
import 'package:almcq/services/database.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class QuizPlayScreen extends StatefulWidget {
  final String quizId;
  final String title;
  final String? tag;
  final bool isCategory;

  const QuizPlayScreen({
    super.key,
    required this.quizId,
    required this.title,
    this.tag,
    this.isCategory = false,
  });

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  final DatabaseService _databaseService = DatabaseService();
  bool _isLoading = true;
  List<QuestionModel> _questions = [];
  int _currentIndex = 0;

  // Question index -> Selected option string
  final Map<int, String> _selectedAnswers = {};
  bool _showExplanation = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() => _isLoading = true);
    try {
      QuerySnapshot snapshot;
      if (widget.isCategory && widget.tag != null && widget.tag!.isNotEmpty) {
        snapshot = await _databaseService.getQuestioCategoriesnData(
          widget.quizId,
          widget.tag!,
        );
      } else {
        snapshot = await _databaseService.getQuestionyearData(widget.quizId);
      }

      final List<QuestionModel> loaded = [];
      for (var doc in snapshot.docs) {
        final q = _parseQuestionFromDoc(doc);
        if (q != null) {
          loaded.add(q);
        }
      }

      if (mounted) {
        setState(() {
          _questions = loaded;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load questions: $e'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }

  QuestionModel? _parseQuestionFromDoc(DocumentSnapshot doc) {
    try {
      final q = QuestionModel();
      q.question = doc.get('question')?.toString() ?? '';

      try {
        q.image = doc.get('image')?.toString();
      } catch (_) {
        q.image = null;
      }

      try {
        q.explanning_image = doc.get('explanning_image')?.toString();
      } catch (_) {
        q.explanning_image = null;
      }

      try {
        q.tag = doc.get('tag')?.toString();
      } catch (_) {
        q.tag = widget.tag;
      }

      final op1 = doc.get('option1')?.toString() ?? '';
      final op2 = doc.get('option2')?.toString() ?? '';
      final op3 = doc.get('option3')?.toString() ?? '';
      final op4 = doc.get('option4')?.toString() ?? '';
      final op5 = doc.get('option5')?.toString() ?? '';

      final List<String> shuffled = [op1, op2, op3, op4, op5]
        ..removeWhere((s) => s.isEmpty)
        ..shuffle();

      q.correctOption = op1;
      q.option1 = shuffled.isNotEmpty ? shuffled[0] : '';
      q.option2 = shuffled.length > 1 ? shuffled[1] : '';
      q.option3 = shuffled.length > 2 ? shuffled[2] : '';
      q.option4 = shuffled.length > 3 ? shuffled[3] : '';
      q.option5 = shuffled.length > 4 ? shuffled[4] : '';
      q.answered = false;

      return q;
    } catch (_) {
      return null;
    }
  }

  int get _correctCount {
    int count = 0;
    _selectedAnswers.forEach((index, answer) {
      if (index < _questions.length &&
          answer == _questions[index].correctOption) {
        count++;
      }
    });
    return count;
  }

  int get _incorrectCount {
    int count = 0;
    _selectedAnswers.forEach((index, answer) {
      if (index < _questions.length &&
          answer != _questions[index].correctOption) {
        count++;
      }
    });
    return count;
  }

  int get _unattemptedCount => _questions.length - _selectedAnswers.length;

  void _onOptionSelected(int qIndex, String option) {
    if (_selectedAnswers.containsKey(qIndex)) return;
    setState(() {
      _selectedAnswers[qIndex] = option;
      _questions[qIndex].answered = true;
    });
  }

  void _showQuestionJumpGrid() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    context.tr('question_overview'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTextPrimary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _IndicatorChip(
                    color: AppTheme.success,
                    label: '${context.tr('correct')}: $_correctCount',
                  ),
                  const SizedBox(width: 8),
                  _IndicatorChip(
                    color: AppTheme.error,
                    label: '${context.tr('wrong')}: $_incorrectCount',
                  ),
                  const SizedBox(width: 8),
                  _IndicatorChip(
                    color: AppTheme.lightCardBorder,
                    label: '${context.tr('skipped')}: $_unattemptedCount',
                    textColor: AppTheme.lightTextPrimary,
                  ),
                ],
              ),
              const Divider(height: 24),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.45,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _questions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final isCurrent = index == _currentIndex;
                    final isAnswered = _selectedAnswers.containsKey(index);
                    Color bgColor = AppTheme.lightBackground;
                    Color textColor = AppTheme.lightTextPrimary;

                    if (isAnswered) {
                      final isCorrect =
                          _selectedAnswers[index] == _questions[index].correctOption;
                      bgColor = isCorrect ? AppTheme.success : AppTheme.error;
                      textColor = Colors.white;
                    }

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                          _showExplanation = false;
                        });
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isCurrent
                                ? AppTheme.primaryColor
                                : AppTheme.lightCardBorder,
                            width: isCurrent ? 2.5 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: isCurrent
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showResultDialog() {
    final total = _questions.length;
    final score = _correctCount;
    final percent = total > 0 ? (score / total * 100).round() : 0;

    String grade = 'F';
    String feedback = 'Keep revising and practice regularly!';
    Color gradeColor = AppTheme.error;

    if (percent >= 75) {
      grade = 'A (Distinction)';
      feedback = 'Outstanding performance! You are exam ready.';
      gradeColor = AppTheme.success;
    } else if (percent >= 65) {
      grade = 'B (Very Good)';
      feedback = 'Great score! A few more revisions for an A.';
      gradeColor = AppTheme.secondaryColor;
    } else if (percent >= 55) {
      grade = 'C (Credit)';
      feedback = 'Good foundation. Review your incorrect answers.';
      gradeColor = AppTheme.primaryColor;
    } else if (percent >= 35) {
      grade = 'S (Pass)';
      feedback = 'Passed! Focus on weaker topics to boost your grade.';
      gradeColor = AppTheme.warning;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: gradeColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.emoji_events_rounded,
                    color: gradeColor, size: 40),
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('quiz_completed'),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.lightBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.lightCardBorder),
                ),
                child: Column(
                  children: [
                    Text(
                      '$score / $total ($percent%)',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: gradeColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${context.tr('grade')}: $grade',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: gradeColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                feedback,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _SummaryStat(
                    label: context.tr('correct'),
                    value: '$score',
                    color: AppTheme.success,
                  ),
                  _SummaryStat(
                    label: context.tr('wrong'),
                    value: '$_incorrectCount',
                    color: AppTheme.error,
                  ),
                  _SummaryStat(
                    label: context.tr('skipped'),
                    value: '$_unattemptedCount',
                    color: AppTheme.lightTextSecondary,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
              child: Text(context.tr('review_answers')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(context.tr('exit_quiz')),
            ),
          ],
        );
      },
    );
  }

  void _showZoomImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(12),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InteractiveViewer(
              minScale: 0.8,
              maxScale: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageController.instance,
      builder: (context, child) {
        if (_isLoading) {
          return Scaffold(
            backgroundColor: AppTheme.lightBackground,
            appBar: AppBar(title: Text(widget.title)),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.threeArchedCircle(
                    color: AppTheme.primaryColor,
                    size: 50,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Loading A/L ICT Questions...',
                    style: TextStyle(
                      color: AppTheme.lightTextSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (_questions.isEmpty) {
          return Scaffold(
            backgroundColor: AppTheme.lightBackground,
            appBar: AppBar(title: Text(widget.title)),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.inventory_2_outlined,
                        size: 64, color: AppTheme.lightTextSecondary),
                    const SizedBox(height: 16),
                    Text(
                      context.tr('no_questions_title'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.tr('no_questions_desc'),
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: AppTheme.lightTextSecondary),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(context.tr('back_to_hub')),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final currentQ = _questions[_currentIndex];
        final selectedOption = _selectedAnswers[_currentIndex];
        final isAnswered = selectedOption != null;

        // Options straight from database
        final options = [
          currentQ.option1,
          currentQ.option2,
          currentQ.option3,
          currentQ.option4,
          currentQ.option5,
        ].where((o) => o != null && o.isNotEmpty).toList();

        return Scaffold(
          backgroundColor: AppTheme.lightBackground,
          appBar: AppBar(
            title: Text('${widget.title} MCQ'),
            actions: [
              IconButton(
                tooltip: context.tr('question_overview'),
                icon: const Icon(Icons.grid_view_rounded),
                onPressed: _showQuestionJumpGrid,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Progress Bar & Question Counter
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${context.tr('question')} ${_currentIndex + 1} ${context.tr('of')} ${_questions.length}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightTextPrimary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${context.tr('score')}: $_correctCount',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.success,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (_currentIndex + 1) / _questions.length,
                          backgroundColor: AppTheme.lightCardBorder,
                          valueColor: const AlwaysStoppedAnimation(
                              AppTheme.primaryColor),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),

                // Question Content & Options (From Database)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Question Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppTheme.lightCardBorder),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (currentQ.tag != null &&
                                  currentQ.tag!.isNotEmpty) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    currentQ.tag!,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              // Raw question text directly from database
                              Text(
                                currentQ.question ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.lightTextPrimary,
                                  height: 1.45,
                                ),
                              ),
                              if (currentQ.image != null &&
                                  currentQ.image!.isNotEmpty &&
                                  (currentQ.image!.startsWith('http://') ||
                                      currentQ.image!.startsWith('https://'))) ...[
                                const SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () => _showZoomImage(currentQ.image!),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl: currentQ.image!,
                                          placeholder: (context, url) =>
                                              Container(
                                            height: 160,
                                            color: AppTheme.lightBackground,
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(
                                                      strokeWidth: 2),
                                            ),
                                          ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const SizedBox.shrink(),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.zoom_in,
                                                size: 14,
                                                color: Colors.white),
                                            const SizedBox(width: 4),
                                            Text(
                                              context.tr('zoom'),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Option Tiles (Raw options from database)
                        ...List.generate(options.length, (opIdx) {
                          final optionText = options[opIdx]!;
                          final letter = String.fromCharCode(65 + opIdx);

                          Color cardColor = Colors.white;
                          Color borderColor = AppTheme.lightCardBorder;
                          Color letterBg = AppTheme.lightBackground;
                          Color letterTextColor = AppTheme.lightTextPrimary;
                          Widget? trailingIcon;

                          if (isAnswered) {
                            final isThisSelected = selectedOption == optionText;
                            final isThisCorrect =
                                optionText == currentQ.correctOption;

                            if (isThisCorrect) {
                              cardColor =
                                  AppTheme.success.withValues(alpha: 0.12);
                              borderColor = AppTheme.success;
                              letterBg = AppTheme.success;
                              letterTextColor = Colors.white;
                              trailingIcon = const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppTheme.success);
                            } else if (isThisSelected) {
                              cardColor =
                                  AppTheme.error.withValues(alpha: 0.12);
                              borderColor = AppTheme.error;
                              letterBg = AppTheme.error;
                              letterTextColor = Colors.white;
                              trailingIcon = const Icon(Icons.cancel_rounded,
                                  color: AppTheme.error);
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () =>
                                  _onOptionSelected(_currentIndex, optionText),
                              borderRadius: BorderRadius.circular(16),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: borderColor, width: 1.5),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: letterBg,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          letter,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: letterTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        optionText,
                                        style: const TextStyle(
                                          fontSize: 14.5,
                                          color: AppTheme.lightTextPrimary,
                                          height: 1.35,
                                        ),
                                      ),
                                    ),
                                    if (trailingIcon != null) trailingIcon,
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),

                        // Explanation Button & Drawer
                        if (isAnswered &&
                            currentQ.explanning_image != null &&
                            currentQ.explanning_image!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              setState(
                                  () => _showExplanation = !_showExplanation);
                            },
                            icon: Icon(
                              _showExplanation
                                  ? Icons.visibility_off_outlined
                                  : Icons.lightbulb_outline_rounded,
                              color: AppTheme.primaryColor,
                              size: 18,
                            ),
                            label: Text(
                              _showExplanation
                                  ? context.tr('hide_explanation')
                                  : context.tr('view_explanation'),
                            ),
                          ),
                          if (_showExplanation) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppTheme.primaryColor
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.info_outline,
                                          color: AppTheme.primaryColor,
                                          size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        context
                                            .tr('marking_scheme_working'),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: currentQ.explanning_image!,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Text(
                                        'Image explanation could not be loaded.',
                                        style:
                                            TextStyle(color: AppTheme.error),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Bottom Navigation Controls
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      OutlinedButton(
                        onPressed: _currentIndex > 0
                            ? () {
                                setState(() {
                                  _currentIndex--;
                                  _showExplanation = false;
                                });
                              }
                            : null,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_back_ios_rounded, size: 14),
                            const SizedBox(width: 4),
                            Text(context.tr('previous')),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (_currentIndex < _questions.length - 1)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex++;
                              _showExplanation = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(context.tr('next')),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 14),
                            ],
                          ),
                        )
                      else
                        ElevatedButton.icon(
                          onPressed: _showResultDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.success,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          icon:
                              const Icon(Icons.check_circle_outline, size: 18),
                          label: Text(context.tr('finish_quiz')),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _IndicatorChip extends StatelessWidget {
  final Color color;
  final String label;
  final Color textColor;

  const _IndicatorChip({
    required this.color,
    required this.label,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
