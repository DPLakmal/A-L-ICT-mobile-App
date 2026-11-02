import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/profile.dart';
import 'package:almcq/services/exit.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:almcq/views/lessons_page.dart';
import 'package:almcq/views/pastpaper_page.dart';
import 'package:almcq/views/quiz_page.dart';
import 'package:almcq/views/shortnote_page.dart';
import 'package:almcq/widgets/bubble_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  User? get user => FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.78,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const ProfilePage(),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return context.tr('good_morning');
    if (hour < 17) return context.tr('good_afternoon');
    return context.tr('good_evening');
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        user?.displayName?.split(' ').first ?? context.tr('student');

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          showExitPopup(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 1,
          title: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  'assets/1024.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.school_rounded,
                    color: AppTheme.primaryColor,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_getGreeting()}, $displayName! 👋',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.lightTextPrimary,
                      ),
                    ),
                    Text(
                      context.tr('app_subtitle'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            const LanguageSelectorButton(),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _showProfileModal,
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                  child: ClipOval(
                    child: user?.photoURL != null && user!.photoURL!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: user!.photoURL!,
                            width: 34,
                            height: 34,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.person,
                              size: 18,
                              color: AppTheme.primaryColor,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 18,
                            color: AppTheme.primaryColor,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const QuizPage(),
            LessonsPage(
              onSelectLessonTag: (tag, year) {
                _pageController.jumpToPage(0);
                setState(() => _currentPage = 0);
              },
            ),
            const ShortNotePage(),
            const PastpaperPage(),
          ],
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
        ),
        bottomNavigationBar: BubbleBottomBar(
          currentIndex: _currentPage,
          opacity: 0.16,
          elevation: 10,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          onTap: (index) {
            if (index == null) return;
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
          },
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
              backgroundColor: const Color(0xFF4F46E5), // Indigo
              icon: const Icon(Icons.quiz_outlined),
              activeIcon: const Icon(Icons.quiz_rounded),
              title: Text(context.tr('tab_quizzes')),
            ),
            BubbleBottomBarItem(
              backgroundColor: const Color(0xFF0D9488), // Teal
              icon: const Icon(Icons.menu_book_outlined),
              activeIcon: const Icon(Icons.menu_book_rounded),
              title: Text(context.tr('tab_lessons')),
            ),
            BubbleBottomBarItem(
              backgroundColor: const Color(0xFFD97706), // Warm Amber
              icon: const Icon(Icons.description_outlined),
              activeIcon: const Icon(Icons.description_rounded),
              title: Text(context.tr('tab_short_notes')),
            ),
            BubbleBottomBarItem(
              backgroundColor: const Color(0xFF059669), // Emerald
              icon: const Icon(Icons.folder_outlined),
              activeIcon: const Icon(Icons.folder_rounded),
              title: Text(context.tr('tab_past_papers')),
            ),
          ],
        ),
      ),
    );
  }
}
