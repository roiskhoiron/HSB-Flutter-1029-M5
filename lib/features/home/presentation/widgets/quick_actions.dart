import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/features/home/presentation/widgets/quick_action_card.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        QuickActionCard(
          icon: Icons.flight_takeoff,
          title: context.l10n.home_upcomingTrips,
          subtitle: context.l10n.viewYourTrips,
          color: context.colorScheme.primary,
          onTap: () => context.goNamed(AppRoutes.trips),
        ),
        QuickActionCard(
          icon: Icons.history,
          title: context.l10n.home_recentlyViewed,
          subtitle: context.l10n.recentPlaces,
          color: context.colorScheme.secondary,
          onTap: () {},
        ),
        QuickActionCard(
          icon: Icons.settings,
          title: context.l10n.settings,
          subtitle: context.l10n.appSettings,
          color: Colors.orange,
          onTap: () => context.goNamed(AppRoutes.settings),
        ),
        QuickActionCard(
          icon: Icons.favorite,
          title: context.l10n.favorites,
          subtitle: context.l10n.savedPlaces,
          color: Colors.red,
          onTap: () {},
        ),
      ],
    );
  }
}
