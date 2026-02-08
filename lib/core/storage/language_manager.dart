import 'package:flutter/material.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/core/storage/preferences_service.dart';

enum AppLanguage { english, indonesian, spanish }

class LanguageManager extends ChangeNotifier {
  static final LanguageManager _instance = LanguageManager._();
  factory LanguageManager() => _instance;
  LanguageManager._();
  final PreferencesService _prefs = PreferencesService();
  AppLanguage _language = AppLanguage.english;
  Locale _locale = const Locale('en');
  AppLanguage get language => _language;
  Locale get locale => _locale;
  Future<void> initialize() async {
    try {
      await _prefs.init();
      final savedLanguage = await _prefs.getLanguage();
      _language = AppLanguage.values[savedLanguage];
      _locale = Locale(getLanguageCode());
    } catch (e) {
      AppLogger.getLogger(
        'LanguageManager',
      ).warning('Error initializing language manager: $e');
      _language = AppLanguage.english;
      _locale = const Locale('en');
    }
    notifyListeners();
  }

  Future<void> setLanguage(AppLanguage language) async {
    try {
      _language = language;
      _locale = Locale(getLanguageCode());
      await _prefs.saveLanguage(language.index);
      notifyListeners();
    } catch (e) {
      AppLogger.getLogger(
        'LanguageManager',
      ).warning('Error setting language: $e');
    }
  }

  void toggleLanguage() {
    final nextIndex = (_language.index + 1) % AppLanguage.values.length;
    setLanguage(AppLanguage.values[nextIndex]);
  }

  String getLanguageCode() {
    switch (_language) {
      case AppLanguage.english:
        return 'en';
      case AppLanguage.indonesian:
        return 'id';
      case AppLanguage.spanish:
        return 'es';
    }
  }

  String getLanguageName() {
    switch (_language) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.indonesian:
        return 'Bahasa Indonesia';
      case AppLanguage.spanish:
        return 'Español';
    }
  }

  static List<Locale> get supportedLocales {
    return const [Locale('en'), Locale('id'), Locale('es')];
  }

  String getLanguageShortName() {
    switch (_language) {
      case AppLanguage.english:
        return 'EN';
      case AppLanguage.indonesian:
        return 'ID';
      case AppLanguage.spanish:
        return 'ES';
    }
  }
}
