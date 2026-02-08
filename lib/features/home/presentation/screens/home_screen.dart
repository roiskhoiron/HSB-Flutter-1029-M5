import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/shared/widgets/app_background_gradient.dart';
import 'package:travel_planner/features/home/presentation/widgets/quick_actions.dart';
import 'package:travel_planner/features/home/presentation/widgets/welcome_header.dart';
import 'package:travel_planner/features/trips/presentation/controllers/trip_view_model.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import 'package:travel_planner/features/trips/presentation/dtos/trip_dto.dart';
import 'package:travel_planner/features/home/presentation/widgets/recent_trips_list.dart';
import 'package:travel_planner/features/home/presentation/widgets/empty_recent_trips.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: AppBackgroundGradient(type: GradientType.topDown),
        ),
        // Content
        Consumer2<TripViewModel, AuthProvider>(
          builder: (context, viewModel, authProvider, _) {
            final trips = viewModel.recentTrips;

            return SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeHeader(user: authProvider.currentUser),
                    const SizedBox(height: 32),
                    Text(
                      context.l10n.quickActions,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const QuickActions(),
                    const SizedBox(height: 32),
                    Text(
                      context.l10n.recentActivity,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (viewModel.isLoading && trips.isEmpty)
                      const Center(child: CircularProgressIndicator())
                    else if (trips.isEmpty)
                      const EmptyRecentTrips()
                    else
                      RecentTripsList(
                        trips: trips.map((trip) => TripDto(trip)).toList(),
                        onTripTap: (dto) => context.pushNamed(
                          AppRoutes.tripDetail,
                          pathParameters: {'id': dto.trip.id},
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
