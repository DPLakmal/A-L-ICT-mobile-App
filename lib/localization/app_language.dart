import 'package:flutter/material.dart';

enum AppLanguage {
  english(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    flag: '🇬🇧',
    locale: Locale('en'),
  ),
  sinhala(
    code: 'si',
    name: 'Sinhala',
    nativeName: 'සිංහල',
    flag: '🇱🇰',
    locale: Locale('si'),
  ),
  tamil(
    code: 'ta',
    name: 'Tamil',
    nativeName: 'தமிழ்',
    flag: '🇱🇰',
    locale: Locale('ta'),
  );

  final String code;
  final String name;
  final String nativeName;
  final String flag;
  final Locale locale;

  const AppLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.locale,
  });

  static AppLanguage fromCode(String code) {
    for (var lang in AppLanguage.values) {
      if (lang.code == code) return lang;
    }
    return AppLanguage.english;
  }
}
