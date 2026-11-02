import 'package:almcq/localization/app_language.dart';
import 'package:almcq/localization/app_translations.dart';
import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:almcq/views/lessons_page.dart';
import 'package:almcq/views/mcq/mcq.dart';
import 'package:almcq/views/mcq/mcq_year.dart';
import 'package:almcq/views/pastpaper_page.dart';
import 'package:almcq/views/shortnote_page.dart';
import 'package:almcq/widgets/bubble_bottom_bar.dart';
import 'package:almcq/widgets/quiz_play_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('AppTheme properties check', (WidgetTester tester) async {
    final light = AppTheme.lightTheme;
    expect(light.useMaterial3, true);
    expect(light.colorScheme.primary, AppTheme.primaryColor);

    final dark = AppTheme.darkTheme;
    expect(dark.useMaterial3, true);
  });

  testWidgets('Language translations test for English, Sinhala and Tamil',
      (WidgetTester tester) async {
    // English
    expect(AppTranslations.get('tab_quizzes', AppLanguage.english), 'Quizzes');
    expect(AppTranslations.get('tab_lessons', AppLanguage.english), 'Lessons');

    // Sinhala
    expect(AppTranslations.get('tab_quizzes', AppLanguage.sinhala), 'ප්‍රශ්නාවලි');
    expect(AppTranslations.get('tab_lessons', AppLanguage.sinhala), 'පාඩම් මාලාව');

    // Tamil
    expect(AppTranslations.get('tab_quizzes', AppLanguage.tamil), 'வினாடி வினா');
    expect(AppTranslations.get('tab_lessons', AppLanguage.tamil), 'பாடங்கள்');

    // Unit titles in all 3 languages
    expect(
      AppTranslations.getUnitTitle('Unit 01', AppLanguage.english, 'Fallback'),
      'Basic Concepts of ICT',
    );
    expect(
      AppTranslations.getUnitTitle('Unit 01', AppLanguage.sinhala, 'Fallback'),
      'තොරතුරු සහ සන්නිවේදන තාක්ෂණයේ මූලික සංකල්ප',
    );
    expect(
      AppTranslations.getUnitTitle('Unit 01', AppLanguage.tamil, 'Fallback'),
      'தகவல் தொடர்பாடல் தொழினுட்பத்தின் அடிப்படைக் கருத்துக்கள்',
    );
  });

  testWidgets('LanguageController switches languages and notifies listeners',
      (WidgetTester tester) async {
    final controller = LanguageController.instance;

    await controller.changeLanguage(AppLanguage.sinhala);
    expect(controller.currentLanguage, AppLanguage.sinhala);
    expect(controller.tr('good_morning'), 'සුබ උදෑසනක්');

    await controller.changeLanguage(AppLanguage.tamil);
    expect(controller.currentLanguage, AppLanguage.tamil);
    expect(controller.tr('good_morning'), 'காலை வணக்கம்');

    await controller.changeLanguage(AppLanguage.english);
    expect(controller.currentLanguage, AppLanguage.english);
    expect(controller.tr('good_morning'), 'Good morning');
  });

  testWidgets('LessonsPage renders all 12 units', (WidgetTester tester) async {
    await LanguageController.instance.changeLanguage(AppLanguage.english);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LessonsPage(),
        ),
      ),
    );

    expect(find.text('Curriculum Units (Units 01 to 12)'), findsOneWidget);
    expect(find.text('Basic Concepts of ICT'), findsOneWidget);
    expect(find.text('Evolution of Computing'), findsOneWidget);
    expect(find.text('Programming with Python'), findsOneWidget);
  });

  testWidgets('McqHubPage renders practice modes without overflow',
      (WidgetTester tester) async {
    await LanguageController.instance.changeLanguage(AppLanguage.english);

    await tester.pumpWidget(
      const MaterialApp(
        home: McqHubPage(),
      ),
    );

    expect(find.text('MCQ Practice Hub'), findsOneWidget);
    expect(find.text('Past Paper MCQs via Year'), findsOneWidget);
    expect(find.text('Categorized by Syllabus Topic'), findsOneWidget);
  });

  testWidgets('McqYearPage renders year list', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: McqYearPage(),
      ),
    );

    expect(find.text('Past Paper MCQs via Year'), findsOneWidget);
    expect(find.text('2021 G.C.E. A/L ICT Paper I'), findsOneWidget);
    expect(find.text('2020 G.C.E. A/L ICT Paper I'), findsOneWidget);
  });

  testWidgets('PastpaperPage renders past papers archives',
      (WidgetTester tester) async {
    await LanguageController.instance.changeLanguage(AppLanguage.english);

    await tester.pumpWidget(
      const MaterialApp(
        home: PastpaperPage(),
      ),
    );

    expect(find.text('National Exam Archives (2015 - 2021)'), findsOneWidget);
    expect(find.text('2021 G.C.E. A/L ICT Examination'), findsOneWidget);
    expect(find.text('MCQ Papers'), findsOneWidget);
    expect(find.text('Structured'), findsOneWidget);
    expect(find.text('Essay Papers'), findsOneWidget);
  });

  testWidgets('ShortNotePage renders high-yield revision topics',
      (WidgetTester tester) async {
    await LanguageController.instance.changeLanguage(AppLanguage.english);

    await tester.pumpWidget(
      const MaterialApp(
        home: ShortNotePage(),
      ),
    );

    expect(find.text('High-Yield Revision Topics'), findsOneWidget);
    expect(
        find.text('Logic Gates & Boolean Algebra Laws'), findsOneWidget);
    expect(find.text('SQL Cheatsheet (DDL, DML, DQL)'), findsOneWidget);
  });

  testWidgets('OptionTile renders interactive states',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OptionTile(
            option: 'A',
            description: 'Central Processing Unit',
            correctAnswer: 'Central Processing Unit',
            optionSelected: 'Central Processing Unit',
          ),
        ),
      ),
    );

    expect(find.text('A'), findsOneWidget);
    expect(find.text('Central Processing Unit'), findsOneWidget);
  });

  testWidgets('BubbleBottomBar renders and handles tab selection without overflow',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              bottomNavigationBar: BubbleBottomBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  setState(() => selectedIndex = index!);
                },
                items: const [
                  BubbleBottomBarItem(
                    icon: Icon(Icons.quiz_outlined),
                    activeIcon: Icon(Icons.quiz),
                    title: Text('Quizzes'),
                    backgroundColor: Color(0xFF4F46E5),
                  ),
                  BubbleBottomBarItem(
                    icon: Icon(Icons.menu_book_outlined),
                    activeIcon: Icon(Icons.menu_book),
                    title: Text('පාඩම් මාලාව'), // Sinhala label
                    backgroundColor: Color(0xFF0D9488),
                  ),
                  BubbleBottomBarItem(
                    icon: Icon(Icons.description_outlined),
                    activeIcon: Icon(Icons.description),
                    title: Text('குறுங்குறிப்புகள்'), // Tamil label
                    backgroundColor: Color(0xFFD97706),
                  ),
                  BubbleBottomBarItem(
                    icon: Icon(Icons.folder_outlined),
                    activeIcon: Icon(Icons.folder),
                    title: Text('Past Papers'),
                    backgroundColor: Color(0xFF059669),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    // Initial state: first tab title is visible
    expect(find.text('Quizzes'), findsOneWidget);
    expect(find.byType(BubbleBottomBar), findsOneWidget);

    // Tap second tab (Sinhala title)
    await tester.tap(find.byIcon(Icons.menu_book_outlined));
    await tester.pumpAndSettle();

    expect(selectedIndex, 1);
    expect(find.text('පාඩම් මාලාව'), findsOneWidget);
  });
}
