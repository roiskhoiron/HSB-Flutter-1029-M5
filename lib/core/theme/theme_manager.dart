import 'package:flutter/material.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/core/storage/preferences_service.dart';

enum AppThemeMode { system, light, dark }

class ThemeManager extends ChangeNotifier {
  static final ThemeManager _instance = ThemeManager._();
  factory ThemeManager() => _instance;
  ThemeManager._();

  final PreferencesService _prefs = PreferencesService();

  AppThemeMode _themeMode = AppThemeMode.dark;

  AppThemeMode get themeMode => _themeMode;

  Future<void> initialize() async {
    try {
      await _prefs.init();
      final savedMode = await _prefs.getThemeMode();
      _themeMode = AppThemeMode.values[savedMode];
    } catch (e) {
      AppLogger.getLogger(
        'ThemeManager',
      ).warning('Error initializing theme manager: $e');
      _themeMode = AppThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    try {
      _themeMode = mode;
      await _prefs.saveThemeMode(mode.index);
      notifyListeners();
    } catch (e) {
      AppLogger.getLogger(
        'ThemeManager',
      ).warning('Error setting theme mode: $e');
    }
  }

  void toggleTheme() {
    switch (_themeMode) {
      case AppThemeMode.system:
        setThemeMode(AppThemeMode.light);
        break;
      case AppThemeMode.light:
        setThemeMode(AppThemeMode.dark);
        break;
      case AppThemeMode.dark:
        setThemeMode(AppThemeMode.system);
        break;
    }
  }

  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  bool isDarkMode(BuildContext context) {
    switch (_themeMode) {
      case AppThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
      case AppThemeMode.light:
        return false;
      case AppThemeMode.dark:
        return true;
    }
  }
}
