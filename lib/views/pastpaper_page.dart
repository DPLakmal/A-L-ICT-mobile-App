import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/models/pdf_model.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:almcq/views/PastPaper/p_essay.dart';
import 'package:almcq/views/PastPaper/p_mcq.dart';
import 'package:almcq/views/PastPaper/p_structured.dart';
import 'package:flutter/material.dart';

class PastpaperPage extends StatefulWidget {
  const PastpaperPage({super.key});

  @override
  State<PastpaperPage> createState() => _PastpaperPageState();
}

// Backwards compatibility alias
// ignore: camel_case_types
typedef Pastpaper_page = PastpaperPage;

class _PastpaperPageState extends State<PastpaperPage> {
  static const List<Map<String, dynamic>> papers = [
    {
      'year': '2021',
      'mcqPdf': 'saa',
      'markingPdf': 's',
      'hasMarking': true,
      'isNewSyllabus': true,
    },
    {
      'year': '2020',
      'mcqPdf': 'saa',
      'markingPdf': 's',
      'hasMarking': true,
      'isNewSyllabus': true,
    },
    {
      'year': '2019',
      'mcqPdf': 'saa',
      'markingPdf': 's',
      'hasMarking': true,
      'isNewSyllabus': true,
    },
    {
      'year': '2018',
      'mcqPdf': 'saa',
      'markingPdf': 's',
      'hasMarking': true,
      'isNewSyllabus': false,
    },
    {
      'year': '2017',
      'mcqPdf': 'saa',
      'markingPdf': 's',
      'hasMarking': true,
      'isNewSyllabus': false,
    },
    {
      'year': '2016',
      'mcqPdf': 'saa',
      'markingPdf': 's',
      'hasMarking': true,
      'isNewSyllabus': false,
    },
    {
      'year': '2015',
      'mcqPdf': 'saa',
      'markingPdf': 's',
      'hasMarking': true,
      'isNewSyllabus': false,
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
                // Top Hero Banner
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.secondaryColor, Color(0xFF0F766E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.secondaryColor.withValues(alpha: 0.25),
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
                              context.tr('past_papers_banner_title'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              context.tr('past_papers_banner_desc'),
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
                          Icons.folder_copy_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Quick Category Shortcuts
                Row(
                  children: [
                    Expanded(
                      child: _CategoryShortcutCard(
                        title: context.tr('mcq_papers'),
                        subtitle: 'Part I',
                        icon: Icons.checklist_rtl_rounded,
                        color: AppTheme.primaryColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Pmcq()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _CategoryShortcutCard(
                        title: context.tr('structured'),
                        subtitle: 'Part II - A',
                        icon: Icons.edit_note_rounded,
                        color: AppTheme.secondaryColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PStructured()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _CategoryShortcutCard(
                        title: context.tr('essay_papers'),
                        subtitle: 'Part II - B',
                        icon: Icons.article_rounded,
                        color: AppTheme.accentRose,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Pessay()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section Header
                Text(
                  context.tr('national_archives'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // Year-by-Year Cards
                ...papers.map((p) {
                  final year = p['year'] as String;
                  final isNewSyllabus = p['isNewSyllabus'] as bool;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                year,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '$year G.C.E. A/L ICT Examination',
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.lightTextPrimary,
                                ),
                              ),
                            ),
                            if (isNewSyllabus)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.success.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  context.tr('new_syllabus'),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.success,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PDF_model(
                                        pdfname: p['mcqPdf'] as String,
                                      ),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  side: const BorderSide(
                                    color: AppTheme.primaryColor,
                                    width: 1.2,
                                  ),
                                ),
                                icon: const Icon(Icons.picture_as_pdf_outlined,
                                    size: 16),
                                label: Text(
                                  context.tr('question_paper'),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PDF_model(
                                        pdfname: p['markingPdf'] as String,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.secondaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                ),
                                icon: const Icon(Icons.check_circle_outline,
                                    size: 16),
                                label: Text(
                                  context.tr('marking_scheme'),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryShortcutCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryShortcutCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
