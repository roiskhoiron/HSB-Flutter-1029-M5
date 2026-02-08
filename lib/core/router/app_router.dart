import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/shared/widgets/navigation/app_shell.dart';
import 'package:travel_planner/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:travel_planner/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:travel_planner/features/home/presentation/screens/home_screen.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import 'package:travel_planner/features/settings/screens/settings_screen.dart';
import 'package:travel_planner/features/trips/presentation/screens/trips_screen.dart';
import 'package:travel_planner/features/trips/presentation/screens/trip_detail_screen.dart';
import 'package:travel_planner/features/saved/screens/saved_screen.dart';

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

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.authPath,
  redirect: (context, state) {
    final authProvider = context.read<AuthProvider>();
    final isLoggedIn = authProvider.isAuthenticated;

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
      name: AppRoutes.auth,
      path: AppRoutes.authPath,
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const SignInScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.signIn,
      path: AppRoutes.signInPath,
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const SignInScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.signUp,
      path: AppRoutes.signUpPath,
      pageBuilder: (context, state) => buildPageTransition(
        context: context,
        state: state,
        child: const SignUpScreen(),
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
          name: AppRoutes.saved,
          path: AppRoutes.savedPath,
          pageBuilder: (context, state) => buildPageTransition(
            context: context,
            state: state,
            child: const SavedScreen(),
          ),
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
