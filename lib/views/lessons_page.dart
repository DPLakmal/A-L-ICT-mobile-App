import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:almcq/views/quiz/quiz_play_screen.dart';
import 'package:flutter/material.dart';

class LessonsPage extends StatelessWidget {
  final void Function(String tag, String year)? onSelectLessonTag;

  const LessonsPage({super.key, this.onSelectLessonTag});

  static const List<Map<String, dynamic>> syllabusUnits = [
    {
      'unit': 'Unit 01',
      'title': 'Basic Concepts of ICT',
      'queryTag': 'Concpet of ICT',
      'icon': Icons.lightbulb_outline_rounded,
      'color': Color(0xFF4F46E5),
      'keyPoints': [
        'Data vs Information & Knowledge',
        'Characteristics of Quality Information',
        'Application of ICT in Education, Health & Industry',
      ],
    },
    {
      'unit': 'Unit 02',
      'title': 'Evolution of Computing',
      'queryTag': 'Computer History',
      'icon': Icons.history_edu_rounded,
      'color': Color(0xFF2563EB),
      'keyPoints': [
        'Historical computing devices (Abacus, Pascaline, Analytical Engine)',
        'Computer Generations (1st to 5th Generation)',
        'Von Neumann Architecture & Stored-Program Concept',
      ],
    },
    {
      'unit': 'Unit 03',
      'title': 'Data Representation & Number Systems',
      'queryTag': 'Number System',
      'icon': Icons.pin_outlined,
      'color': Color(0xFF0284C7),
      'keyPoints': [
        'Conversions between Decimal, Binary, Octal & Hexadecimal',
        'Signed Number Representation & 2’s Complement Arithmetic',
        'Character Encoding: BCD, ASCII, EBCDIC & Unicode',
      ],
    },
    {
      'unit': 'Unit 04',
      'title': 'Digital Logic & Boolean Algebra',
      'queryTag': 'Logic Gates',
      'icon': Icons.memory_rounded,
      'color': Color(0xFF0D9488),
      'keyPoints': [
        'Basic Logic Gates (AND, OR, NOT) & Universal Gates (NAND, NOR)',
        'Boolean Algebra Laws & De Morgan’s Theorems',
        'Truth Tables, Karnaugh Maps (K-Maps) & Half/Full Adders',
      ],
    },
    {
      'unit': 'Unit 05',
      'title': 'Operating Systems & System Software',
      'queryTag': 'Operating Systems',
      'icon': Icons.terminal_rounded,
      'color': Color(0xFF059669),
      'keyPoints': [
        'Role and functions of an Operating System',
        'Process Management & CPU Scheduling Algorithms',
        'Memory Management, Virtual Memory & File Systems',
      ],
    },
    {
      'unit': 'Unit 06',
      'title': 'Data Communication & Computer Networks',
      'queryTag': 'Networking',
      'icon': Icons.hub_rounded,
      'color': Color(0xFF16A34A),
      'keyPoints': [
        'Transmission Media (Guided & Unguided) and Topologies',
        'OSI 7-Layer Reference Model & TCP/IP Protocol Suite',
        'IPv4 vs IPv6 Addressing, Subnet Masks & Networking Devices',
      ],
    },
    {
      'unit': 'Unit 07',
      'title': 'Systems Analysis & Design (SAD)',
      'queryTag': 'System Analysis & Design',
      'icon': Icons.account_tree_rounded,
      'color': Color(0xFFD97706),
      'keyPoints': [
        'System Development Life Cycle (SDLC) Phases',
        'Development Models: Waterfall, Spiral, Agile & Prototyping',
        'Data Flow Diagrams (DFD) & Entity-Relationship (ER) Modeling',
      ],
    },
    {
      'unit': 'Unit 08',
      'title': 'Database Management Systems (DBMS)',
      'queryTag': 'Database Management',
      'icon': Icons.storage_rounded,
      'color': Color(0xFFEA580C),
      'keyPoints': [
        'Database architecture and Relational Model',
        'Database Normalization (1NF, 2NF, 3NF)',
        'Structured Query Language (SQL): DDL, DML & DQL queries',
      ],
    },
    {
      'unit': 'Unit 09',
      'title': 'Programming with Python',
      'queryTag': 'Programming',
      'icon': Icons.code_rounded,
      'color': Color(0xFFDC2626),
      'keyPoints': [
        'Data Types, Variables, Operators & Expressions',
        'Control Structures: if-else, while loops & for loops',
        'Functions, Lists, Tuples, Dictionaries & File Handling',
      ],
    },
    {
      'unit': 'Unit 10',
      'title': 'Web Development (HTML/CSS/JS/PHP)',
      'queryTag': 'Web Development',
      'icon': Icons.web_rounded,
      'color': Color(0xFF7C3AED),
      'keyPoints': [
        'HTML5 Semantic Markup & Form Elements',
        'CSS3 Styling, Selectors & Box Model',
        'Client-side JavaScript validation & Server-side PHP basics',
      ],
    },
    {
      'unit': 'Unit 11',
      'title': 'Internet of Things (IoT)',
      'queryTag': 'Internet Of Things',
      'icon': Icons.sensors_rounded,
      'color': Color(0xFF9333EA),
      'keyPoints': [
        'Architecture of IoT: Sensors, Actuators & Gateways',
        'Microcontrollers (Arduino, Raspberry Pi) & Connectivity',
        'Smart Agriculture, Home Automation & Healthcare applications',
      ],
    },
    {
      'unit': 'Unit 12',
      'title': 'ICT in Business & Emerging Trends',
      'queryTag': 'ICT In Business',
      'icon': Icons.business_center_rounded,
      'color': Color(0xFF475569),
      'keyPoints': [
        'E-Commerce models (B2B, B2C, C2C) & Online Payment Gateways',
        'Cloud Computing (SaaS, PaaS, IaaS) & Big Data',
        'Cybersecurity, Intellectual Property & Computer Crimes Act',
      ],
    },
  ];

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
                // Top Curriculum Banner
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryColor, Color(0xFF6366F1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr('syllabus_lessons_title'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              context.tr('syllabus_lessons_desc'),
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Colors.white70,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                Text(
                  context.tr('curriculum_units'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // Units List
                ...syllabusUnits.map((u) {
                  final color = u['color'] as Color;
                  final keyPoints = u['keyPoints'] as List<String>;
                  final unitKey = u['unit'] as String;
                  final defaultTitle = u['title'] as String;
                  final localizedTitle = LanguageController.instance
                      .trUnit(unitKey, defaultTitle);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppTheme.lightCardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(u['icon'] as IconData,
                                  color: color, size: 22),
                            ),
                            const SizedBox(width: 12),
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
                                      unitKey,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: color,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    localizedTitle,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.lightTextPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        // Key points
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: keyPoints.map((pt) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      pt,
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        color: AppTheme.lightTextSecondary,
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        // Action button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizPlayScreen(
                                    quizId: 'JxEc91kikfXAFx1VqAWN',
                                    title: localizedTitle,
                                    tag: u['queryTag'] as String,
                                    isCategory: true,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(Icons.quiz_outlined, size: 16),
                            label: Text(
                              '${context.tr('practice_unit_mcqs')} ($unitKey)',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Backwards compatibility alias
// ignore: camel_case_types
typedef Lessons_Page = LessonsPage;
