import 'package:almcq/views/quiz/quiz_play_screen.dart';
import 'package:flutter/material.dart';

class QuizPlay extends StatelessWidget {
  final String quizId;
  final bool iscategories;
  final String title;

  const QuizPlay({
    required this.quizId,
    this.iscategories = false,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QuizPlayScreen(
      quizId: quizId,
      title: title,
      isCategory: iscategories,
    );
  }
}
