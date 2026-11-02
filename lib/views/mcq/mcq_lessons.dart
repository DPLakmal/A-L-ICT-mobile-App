import 'package:almcq/theme/app_theme.dart';
import 'package:almcq/views/mcq/mcq_lessons_select.dart';
import 'package:flutter/material.dart';

class McqLessonsPage extends StatelessWidget {
  const McqLessonsPage({super.key});

  static const List<Map<String, String>> years = [
    {'year': '2021', 'quizId': 'JxEc91kikfXAFx1VqAWN'},
    {'year': '2020', 'quizId': '7cKYH7YIOJfLXVRg'},
    {'year': '2019', 'quizId': '0036767856232765'},
    {'year': '2018', 'quizId': 'BRVM2u42YNRO555D'},
    {'year': '2017', 'quizId': 'one-seven'},
    {'year': '2016', 'quizId': 'one-six'},
    {'year': '2015', 'quizId': 'one-five'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Categorized Syllabus Lessons'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: years.length,
        itemBuilder: (context, index) {
          final item = years[index];
          final year = item['year']!;
          final quizId = item['quizId']!;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => McqLessonsSelectPage(
                      year: year,
                      quizId: quizId,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.lightCardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.topic_rounded,
                          color: AppTheme.secondaryColor,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$year Topic-Wise MCQs',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Browse questions organized across 12 syllabus units',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.lightTextSecondary,
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
typedef Mcq_Lessons = McqLessonsPage;
