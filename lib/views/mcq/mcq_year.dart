import 'package:almcq/theme/app_theme.dart';
import 'package:almcq/views/quiz/quiz_play_screen.dart';
import 'package:flutter/material.dart';

class McqYearPage extends StatelessWidget {
  const McqYearPage({super.key});

  static const List<Map<String, dynamic>> yearPapers = [
    {
      'year': '2021',
      'quizId': 'JxEc91kikfXAFx1VqAWN',
      'mcqs': 50,
      'duration': '2 Hours',
      'badge': 'Recent Syllabus',
      'color': Color(0xFF4F46E5),
    },
    {
      'year': '2020',
      'quizId': '7cKYH7YIOJfLXVRg',
      'mcqs': 50,
      'duration': '2 Hours',
      'badge': 'Official National Exam',
      'color': Color(0xFF0D9488),
    },
    {
      'year': '2019',
      'quizId': '0036767856232765',
      'mcqs': 50,
      'duration': '2 Hours',
      'badge': 'Official National Exam',
      'color': Color(0xFF2563EB),
    },
    {
      'year': '2018',
      'quizId': 'BRVM2u42YNRO555D',
      'mcqs': 50,
      'duration': '2 Hours',
      'badge': 'Official National Exam',
      'color': Color(0xFF7C3AED),
    },
    {
      'year': '2017',
      'quizId': 'one-seven',
      'mcqs': 50,
      'duration': '2 Hours',
      'badge': 'Past Paper Archive',
      'color': Color(0xFF059669),
    },
    {
      'year': '2016',
      'quizId': 'one-six',
      'mcqs': 50,
      'duration': '2 Hours',
      'badge': 'Past Paper Archive',
      'color': Color(0xFFD97706),
    },
    {
      'year': '2015',
      'quizId': 'one-five',
      'mcqs': 50,
      'duration': '2 Hours',
      'badge': 'Past Paper Archive',
      'color': Color(0xFFDC2626),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Past Paper MCQs via Year'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: yearPapers.length,
        itemBuilder: (context, index) {
          final paper = yearPapers[index];
          final color = paper['color'] as Color;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPlayScreen(
                      quizId: paper['quizId'] as String,
                      title: '${paper['year']} A/L ICT',
                      isCategory: false,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.lightCardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Year Box
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: color.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          paper['year'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  paper['badge'] as String,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${paper['year']} G.C.E. A/L ICT Paper I',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${paper['mcqs']} MCQs • ${paper['duration']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.lightTextSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: AppTheme.lightTextSecondary,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Backwards compatibility alias
// ignore: camel_case_types
typedef Mcq_Year = McqYearPage;
