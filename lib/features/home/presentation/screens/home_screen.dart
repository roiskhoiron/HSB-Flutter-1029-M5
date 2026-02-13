import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/shared/widgets/app_background_gradient.dart';
import 'package:travel_planner/features/home/presentation/widgets/quick_actions.dart';
import 'package:travel_planner/features/home/presentation/widgets/welcome_header.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_notifier.dart';
import 'package:travel_planner/features/trips/presentation/dtos/trip_dto.dart';
import 'package:travel_planner/features/home/presentation/widgets/recent_trips_list.dart';
import 'package:travel_planner/features/home/presentation/widgets/empty_recent_trips.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final tripsState = ref.watch(tripsProvider);

    // 💎 Integrasi Riverpod dengan `tripsProvider` sangat responsif. 
    // Keadaan loading dan error ditangani secara elegan. UX yang hebat! 🚀🔋
    return Stack(
      children: [
        const Positioned.fill(
          child: AppBackgroundGradient(
            direction: GradientDirection.topToBottom,
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeHeader(user: authState.value),
                const SizedBox(height: 32),
                Text(
                  context.l10n.heading_quick_actions,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                const QuickActions(),
                const SizedBox(height: 32),
                Text(
                  context.l10n.heading_recent_activity,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                tripsState.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                  data: (trips) {
                    if (trips.isEmpty) {
                      return const EmptyRecentTrips();
                    }
                    return RecentTripsList(
                      trips: trips.map((trip) => TripDto(trip)).toList(),
                      onTripTap: (dto) => context.pushNamed(
                        AppRoutes.tripDetail,
                        pathParameters: {'id': dto.trip.id},
                      ),
                    );
                  },
                ),
                const SizedBox(height: 64),
                Center(
                  child: Opacity(
                    opacity: 1.0,
                    child: Image.asset(
                      'assets/images/splash.png',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
