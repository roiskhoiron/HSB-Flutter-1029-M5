import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._();
  factory PreferencesService() => _instance;
  PreferencesService._();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveThemeMode(int mode) async {
    await _prefs?.setInt('theme_mode', mode);
  }

  Future<int> getThemeMode() async {
    return _prefs?.getInt('theme_mode') ?? 0;
  }

  Future<void> saveLanguage(int language) async {
    await _prefs?.setInt('language', language);
  }

  Future<int> getLanguage() async {
    return _prefs?.getInt('language') ?? 0;
  }

  Future<void> saveUserId(String userId) async {
    await _prefs?.setString('user_id', userId);
  }

  String? getUserId() {
    return _prefs?.getString('user_id');
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
