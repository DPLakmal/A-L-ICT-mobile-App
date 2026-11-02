import 'package:almcq/views/quiz/quiz_play_screen.dart';
import 'package:flutter/material.dart';

class QuizPlay extends StatelessWidget {
  final String quizId;

  const QuizPlay(this.quizId, {super.key});

  @override
  Widget build(BuildContext context) {
    return QuizPlayScreen(
      quizId: quizId,
      title: 'A/L ICT Practice',
      isCategory: false,
    );
  }
}
