import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travel_planner/core/bootstrap/app_initializer.dart';
import 'package:travel_planner/core/router/app_router.dart';
import 'package:travel_planner/core/providers/language_notifier.dart';
import 'package:travel_planner/core/providers/theme_notifier.dart';
import 'package:travel_planner/core/localization/language_config.dart';
import 'package:travel_planner/core/constants/app_constants.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

void main() async {
  await AppInitializer.initialize();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

// 🚩 Point of Interest: Kamu menggunakan `flutter_riverpod` untuk manajemen tema dan data. 
// Meskipun ini sangat bagus untuk skala produksi, mohon diingat bahwa requirement 
// Mission 5 spesifik meminta penggunaan `setState`. Tetap semangat eksplorasi! 🚀
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLanguageConfig.supportedLocales,
      locale: locale,
      theme: themeNotifier.lightTheme,
      darkTheme: themeNotifier.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
