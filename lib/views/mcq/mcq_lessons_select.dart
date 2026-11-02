import 'package:almcq/theme/app_theme.dart';
import 'package:almcq/views/quiz/quiz_play_screen.dart';
import 'package:flutter/material.dart';

class McqLessonsSelectPage extends StatelessWidget {
  final String year;
  final String quizId;

  const McqLessonsSelectPage({
    super.key,
    required this.year,
    required this.quizId,
  });

  static const List<Map<String, dynamic>> topics = [
    {
      'title': 'Concept of ICT',
      'queryTag': 'Concpet of ICT', // Original Firestore tag
      'unit': 'Unit 01',
      'icon': Icons.lightbulb_rounded,
      'color': Color(0xFF4F46E5),
    },
    {
      'title': 'Evolution & History of Computing',
      'queryTag': 'Computer History',
      'unit': 'Unit 02',
      'icon': Icons.history_rounded,
      'color': Color(0xFF2563EB),
    },
    {
      'title': 'Data Representation & Number Systems',
      'queryTag': 'Number System',
      'unit': 'Unit 03',
      'icon': Icons.pin_outlined,
      'color': Color(0xFF0284C7),
    },
    {
      'title': 'Digital Logic & Boolean Algebra',
      'queryTag': 'Logic Gates',
      'unit': 'Unit 04',
      'icon': Icons.memory_rounded,
      'color': Color(0xFF0D9488),
    },
    {
      'title': 'Operating Systems & System Software',
      'queryTag': 'Operating Systems',
      'unit': 'Unit 05',
      'icon': Icons.terminal_rounded,
      'color': Color(0xFF059669),
    },
    {
      'title': 'Data Communication & Computer Networks',
      'queryTag': 'Networking',
      'unit': 'Unit 06',
      'icon': Icons.hub_rounded,
      'color': Color(0xFF16A34A),
    },
    {
      'title': 'Systems Analysis & Design (SAD)',
      'queryTag': 'System Analysis & Design',
      'unit': 'Unit 07',
      'icon': Icons.account_tree_rounded,
      'color': Color(0xFFD97706),
    },
    {
      'title': 'Database Management Systems (DBMS)',
      'queryTag': 'Database Management',
      'unit': 'Unit 08',
      'icon': Icons.storage_rounded,
      'color': Color(0xFFEA580C),
    },
    {
      'title': 'Programming with Python',
      'queryTag': 'Programming',
      'unit': 'Unit 09',
      'icon': Icons.code_rounded,
      'color': Color(0xFFDC2626),
    },
    {
      'title': 'Web Development (HTML/CSS/JS/PHP)',
      'queryTag': 'Web Development',
      'unit': 'Unit 10',
      'icon': Icons.web_rounded,
      'color': Color(0xFF7C3AED),
    },
    {
      'title': 'Internet of Things (IoT)',
      'queryTag': 'Internet Of Things',
      'unit': 'Unit 11',
      'icon': Icons.sensors_rounded,
      'color': Color(0xFF9333EA),
    },
    {
      'title': 'ICT in Business & Emerging Trends',
      'queryTag': 'ICT In Business',
      'unit': 'Unit 12',
      'icon': Icons.business_center_rounded,
      'color': Color(0xFF475569),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: Text('$year Category Lessons'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          final color = topic['color'] as Color;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPlayScreen(
                      quizId: quizId,
                      title: '$year ${topic['title']}',
                      tag: topic['queryTag'] as String,
                      isCategory: true,
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
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(topic['icon'] as IconData,
                          color: color, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              topic['unit'] as String,
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: color,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            topic['title'] as String,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
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
typedef Mcq_Lessons_Select = McqLessonsSelectPage;
