import 'package:almcq/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_language.dart';
import 'app_translations.dart';

class LanguageController extends ChangeNotifier {
  static final LanguageController instance = LanguageController._internal();

  LanguageController._internal();

  static const String _prefKey = 'selected_language_code';

  AppLanguage _currentLanguage = AppLanguage.english;

  AppLanguage get currentLanguage => _currentLanguage;

  Locale get currentLocale => _currentLanguage.locale;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefKey);
      if (code != null) {
        _currentLanguage = AppLanguage.fromCode(code);
        notifyListeners();
      }
    } catch (_) {
      // Fallback to default
    }
  }

  Future<void> changeLanguage(AppLanguage language) async {
    if (_currentLanguage == language) return;
    _currentLanguage = language;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, language.code);
    } catch (_) {}
  }

  String tr(String key) {
    return AppTranslations.get(key, _currentLanguage);
  }

  String trUnit(String unitKey, String defaultTitle) {
    return AppTranslations.getUnitTitle(unitKey, _currentLanguage, defaultTitle);
  }
}

extension LocalizationExtension on BuildContext {
  String tr(String key) => LanguageController.instance.tr(key);
  AppLanguage get currentLanguage => LanguageController.instance.currentLanguage;
}

class LanguageSelectorButton extends StatelessWidget {
  const LanguageSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageController.instance,
      builder: (context, child) {
        final current = LanguageController.instance.currentLanguage;

        return InkWell(
          onTap: () => showLanguageBottomSheet(context),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  current.flag,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 6),
                Text(
                  current.nativeName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<void> showLanguageBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.lightCardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.translate_rounded,
                    color: AppTheme.primaryColor, size: 24),
                const SizedBox(width: 12),
                Text(
                  LanguageController.instance.tr('select_language'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.lightTextPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...AppLanguage.values.map((lang) {
              final isSelected =
                  LanguageController.instance.currentLanguage == lang;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    LanguageController.instance.changeLanguage(lang);
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryColor.withValues(alpha: 0.1)
                          : AppTheme.lightBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : AppTheme.lightCardBorder,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          lang.flag,
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang.nativeName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : AppTheme.lightTextPrimary,
                              ),
                            ),
                            Text(
                              lang.name,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppTheme.primaryColor,
                            size: 22,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
