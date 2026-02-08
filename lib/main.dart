import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:travel_planner/core/bootstrap/app_initializer.dart';
import 'package:travel_planner/core/di/service_locator.dart';
import 'package:travel_planner/core/router/app_router.dart';
import 'package:travel_planner/features/trips/presentation/controllers/trip_view_model.dart';
import 'package:travel_planner/features/trips/domain/usecases/trip_usecases.dart';
import 'package:travel_planner/core/providers/language_provider.dart';
import 'package:travel_planner/core/providers/theme_provider.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import 'package:travel_planner/core/constants/app_constants.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

void main() async {
  final initResult = await AppInitializer.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: initResult.languageProvider),
        ChangeNotifierProvider.value(value: initResult.themeProvider),
        ChangeNotifierProvider.value(value: initResult.authProvider),
        ChangeNotifierProxyProvider<AuthProvider, TripViewModel>(
          create: (context) => TripViewModel(
            useCases: serviceLocator<TripUseCases>(),
            userId: context.read<AuthProvider>().currentUser?.id ?? '',
          )..loadTrips(),
          update: (context, auth, previous) {
            final userId = auth.currentUser?.id ?? '';
            previous?.updateUserId(userId);
            return previous!;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, language, theme, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: language.supportedLocales,
          locale: language.currentLocale,
          theme: theme.lightTheme,
          darkTheme: theme.darkTheme,
          themeMode: theme.themeMode,
          routerConfig: appRouter,
        );
      },
    );
  }
}
