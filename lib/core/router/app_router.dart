import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/shared/widgets/navigation/app_shell.dart';
import 'package:travel_planner/features/splash/presentation/screens/splash_screen.dart';
import 'package:travel_planner/features/auth/presentation/screens/auth_screen.dart';
import 'package:travel_planner/features/home/presentation/screens/home_screen.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/settings/screens/settings_screen.dart';
import 'package:travel_planner/features/trips/presentation/screens/trips_screen.dart';
import 'package:travel_planner/features/trips/presentation/screens/trip_detail_screen.dart';

import 'package:travel_planner/features/trip_lists/presentation/screens/trip_lists_screen.dart';
import 'package:travel_planner/features/trip_lists/presentation/screens/trip_notes_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Helper to build consistent custom transitions across the app
CustomTransitionPage buildPageTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeIn).animate(animation),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      );
    },
  );
}

// 💎 Implementasi `GoRouter` dengan ShellRoute untuk navigasi bawah (bottom nav) 
// adalah standar emas aplikasi Flutter modern. Navigasinya sangat smooth! 🛤️💎
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      // If still loading auth state, don't redirect yet (or show splash)
      if (authState.isLoading) return null;

      final isLoggedIn = authState.value != null;

      // Allow splash screen to be accessible
      if (state.uri.toString() == '/splash') return null;

      // 💎 Guard logic di `redirect` untuk menangani status login secara otomatis 
      // sangat krusial untuk keamanan data aplikasi. Implementasi yang cerdas! 🛡️🔒
      if (!isLoggedIn && !state.uri.toString().startsWith('/auth')) {
        return AppRoutes.authPath;
      }

      if (isLoggedIn && state.uri.toString().startsWith('/auth')) {
        return AppRoutes.homePath;
      }

      return null;
    },
    routes: [
      GoRoute(
        name: 'splash',
        path: '/splash',
        pageBuilder: (context, state) => buildPageTransition(
          context: context,
          state: state,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.auth,
        path: AppRoutes.authPath,
        pageBuilder: (context, state) => buildPageTransition(
          context: context,
          state: state,
          child: const AuthScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            name: AppRoutes.home,
            path: AppRoutes.homePath,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            name: AppRoutes.trips,
            path: AppRoutes.tripsPath,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: const TripsScreen(),
            ),
            routes: [
              GoRoute(
                name: AppRoutes.tripDetail,
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  final tripId = state.pathParameters['id']!;
                  return buildPageTransition(
                    context: context,
                    state: state,
                    child: TripDetailScreen(tripId: tripId),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.lists,
            path: AppRoutes.listsPath,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: const TripListsScreen(),
            ),
            routes: [
              GoRoute(
                name: AppRoutes.tripLists,
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  final tripId = state.pathParameters['id']!;
                  return buildPageTransition(
                    context: context,
                    state: state,
                    child: TripNotesScreen(tripId: tripId),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.settings,
            path: AppRoutes.settingsPath,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: const SettingsScreen(),
            ),
          ),
          GoRoute(
            name: AppRoutes.profile,
            path: AppRoutes.profilePath,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});
