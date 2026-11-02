import 'package:almcq/views/quiz/quiz_play_screen.dart';
import 'package:flutter/material.dart';

class QuizPlay extends StatelessWidget {
  final String quizId;
  final String title;
  final String tag;
  final bool iscategories;

  const QuizPlay({
    required this.quizId,
    required this.title,
    required this.tag,
    this.iscategories = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QuizPlayScreen(
      quizId: quizId,
      title: title,
      tag: tag,
      isCategory: iscategories,
    );
  }
}
