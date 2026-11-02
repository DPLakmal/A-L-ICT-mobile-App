import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/services/admob.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:almcq/views/PastPaper/p_essay.dart';
import 'package:almcq/views/PastPaper/p_structured.dart';
import 'package:almcq/views/mcq/mcq.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

// Alias for backwards compatibility
// ignore: camel_case_types
typedef Quiz_page = QuizPage;

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageController.instance,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppTheme.lightBackground,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Dashboard Image Slideshow from Firestore
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('DashBoard_Images')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return Container(
                        height: 180,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.lightCardBorder),
                        ),
                        child: Center(
                          child: LoadingAnimationWidget.horizontalRotatingDots(
                            color: AppTheme.primaryColor,
                            size: 40,
                          ),
                        ),
                      );
                    }

                    List<Widget> sliderItems = [];
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      for (var doc in snapshot.data!.docs) {
                        final data = doc.data() as Map<String, dynamic>?;
                        final url = data?['a'] as String?;
                        if (url != null && url.isNotEmpty) {
                          sliderItems.add(
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: url,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) => Container(
                                  color: AppTheme.primaryColor
                                      .withValues(alpha: 0.05),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/1024.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    }

                    if (sliderItems.isEmpty) {
                      sliderItems.add(
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppTheme.primaryColor, Color(0xFF6366F1)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'A/L ICT Success 🚀',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      context.tr('exam_mode_desc'),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.laptop_chromebook_rounded,
                                size: 64,
                                color: Colors.white24,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Container(
                      height: 190,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ImageSlideshow(
                          indicatorColor: AppTheme.primaryColor,
                          indicatorBackgroundColor: Colors.white54,
                          autoPlayInterval: 4000,
                          isLoop: true,
                          children: sliderItems,
                        ),
                      ),
                    );
                  },
                ),

                // 2. Special Notice Stream (Firestore 'Spefical Notic')
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Spefical Notic')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    final notices = snapshot.data!.docs;
                    return Column(
                      children: notices.map((doc) {
                        final data = doc.data() as Map<String, dynamic>?;
                        final message = data?['message'] as String?;
                        if (message == null || message.trim().isEmpty) {
                          return const SizedBox.shrink();
                        }
                        final link = data?['link'] as String?;
                        final buttonName = data?['buttonName'] as String?;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.accentColor.withValues(alpha: 0.12),
                                Colors.white,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  AppTheme.accentColor.withValues(alpha: 0.3),
                              width: 1.2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.campaign_rounded,
                                      color: AppTheme.accentColor, size: 22),
                                  const SizedBox(width: 8),
                                  Text(
                                    context.tr('special_announcement'),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFB45309),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                message,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  color: AppTheme.lightTextPrimary,
                                  height: 1.4,
                                ),
                              ),
                              if (link != null &&
                                  buttonName != null &&
                                  buttonName.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final uri = Uri.tryParse(link);
                                    if (uri != null &&
                                        await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.accentColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    textStyle: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  icon: const Icon(Icons.open_in_new, size: 16),
                                  label: Text(buttonName),
                                ),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                // 3. Section Header: Practice & Question Papers
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        context.tr('practice_papers_quizzes'),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.lightTextPrimary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        context.tr('select_type'),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.lightTextSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                // 4. MCQ Practice Card (Hero Card)
                _PaperTypeCard(
                  title: context.tr('mcq_hub_title'),
                  subtitle: context.tr('mcq_hub_subtitle'),
                  tag: 'PART I • TIMED',
                  tagColor: AppTheme.primaryColor,
                  icon: Icons.checklist_rounded,
                  gradientColors: const [Color(0xFF4F46E5), Color(0xFF6366F1)],
                  badgeText: '500+ MCQs',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const McqHubPage()),
                    );
                  },
                ),
                const SizedBox(height: 14),

                // 5. Structured Essay Card
                _PaperTypeCard(
                  title: context.tr('structured_essay_title'),
                  subtitle: context.tr('structured_essay_subtitle'),
                  tag: 'PART II • STRUCTURED',
                  tagColor: AppTheme.secondaryColor,
                  icon: Icons.edit_note_rounded,
                  gradientColors: const [Color(0xFF0D9488), Color(0xFF14B8A6)],
                  badgeText: 'Part II - A',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PStructured()),
                    );
                  },
                ),
                const SizedBox(height: 14),

                // 6. Essay Questions Card
                _PaperTypeCard(
                  title: context.tr('essay_paper_title'),
                  subtitle: context.tr('essay_paper_subtitle'),
                  tag: 'PART II • ESSAY',
                  tagColor: AppTheme.accentRose,
                  icon: Icons.article_rounded,
                  gradientColors: const [Color(0xFFE11D48), Color(0xFFF43F5E)],
                  badgeText: 'Part II - B',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Pessay()),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 7. Study Tip Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.lightCardBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.lightbulb_rounded,
                            color: AppTheme.primaryColor, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr('study_tip_title'),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              context.tr('study_tip_desc'),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.lightTextSecondary,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 8. Ad slot
                const AdWidget(ad: null),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PaperTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;
  final Color tagColor;
  final IconData icon;
  final List<Color> gradientColors;
  final String badgeText;
  final VoidCallback onTap;

  const _PaperTypeCard({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.tagColor,
    required this.icon,
    required this.gradientColors,
    required this.badgeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.lightCardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors.first.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: tagColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: tagColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        badgeText,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.lightTextSecondary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppTheme.lightTextSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
