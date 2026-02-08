import 'package:flutter/material.dart';
import 'package:travel_planner/core/utils/string_utils.dart';

class AppLanguageConfig {
  static const List<AppLanguage> all = [
    AppLanguage(code: 'en', countryCode: 'US', nativeName: 'English'),
    AppLanguage(code: 'es', countryCode: 'ES', nativeName: 'Español'),
    AppLanguage(code: 'id', countryCode: 'ID', nativeName: 'Indonesia'),
  ];

  static AppLanguage? get(String code) {
    return all.firstWhere((lang) => lang.code == code);
  }

  static List<Locale> get supportedLocales {
    return all.map((lang) => Locale(lang.code)).toList();
  }

  static AppLanguage? fromLocale(Locale locale) {
    return all.firstWhere((lang) => lang.code == locale.languageCode);
  }
}

class AppLanguage {
  final String code;
  final String countryCode;
  final String nativeName;

  String get emoji => countryCode.toFlag;
  const AppLanguage({
    required this.code,
    required this.countryCode,
    required this.nativeName,
  });
}
