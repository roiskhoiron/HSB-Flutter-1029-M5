import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/core/di/service_locator.dart';
import 'package:travel_planner/core/providers/language_provider.dart';
import 'package:travel_planner/core/providers/theme_provider.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import 'package:travel_planner/features/auth/domain/usecases/authentication_usecase.dart';

class AppInitializer {
  static Future<InitializationResult> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 1. Initialize Logger
    AppLogger.initialize(
      level: LogLevel.debug,
      enableFileLogging: !kDebugMode,
      logDirectory: '/tmp/travel_planner_logs',
    );

    final logger = AppLogger.getLogger('AppInitializer');
    logger.info('Starting app initialization...');

    // 2. Setup Service Locator (DI)
    await setupServiceLocator();

    // 3. Initialize core providers
    final languageProvider = LanguageProvider();
    await languageProvider.loadLanguage();

    final themeProvider = ThemeProvider();
    await themeProvider.loadTheme();

    // 4. Initialize Auth Provider
    final authProvider = AuthProvider(
      authenticationUseCase: serviceLocator<AuthenticationUseCase>(),
    );
    await authProvider.initialize();

    logger.info('App initialization completed.');

    return InitializationResult(
      languageProvider: languageProvider,
      themeProvider: themeProvider,
      authProvider: authProvider,
    );
  }
}

class InitializationResult {
  final LanguageProvider languageProvider;
  final ThemeProvider themeProvider;
  final AuthProvider authProvider;

  InitializationResult({
    required this.languageProvider,
    required this.themeProvider,
    required this.authProvider,
  });
}
