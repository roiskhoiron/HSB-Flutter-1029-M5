import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/shared/widgets/stat_card.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class TripStatistics extends StatelessWidget {
  final List<Trip> trips;
  const TripStatistics({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final totalBudget = trips.fold(
      0.0,
      (sum, trip) => sum + trip.budget.amount,
    );
    final upcomingTrips = trips
        .where((trip) => trip.status == TripStatus.upcoming)
        .length;
    final completedTrips = trips
        .where((trip) => trip.status == TripStatus.completed)
        .length;

    return SectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        spacing: 12,
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: StatCard(
                  title: loc.totalTrips,
                  value: '${trips.length}',
                  icon: Icons.flight_takeoff_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),
              Expanded(
                child: StatCard(
                  title: loc.totalBudget,
                  value: '\$${_formatBudget(totalBudget)}',
                  icon: Icons.account_balance_wallet_outlined,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: StatCard(
                  title: loc.ongoing,
                  value: '$upcomingTrips',
                  icon: Icons.upcoming_outlined,
                  color: Colors.orange,
                ),
              ),
              Expanded(
                child: StatCard(
                  title: loc.completed,
                  value: '$completedTrips',
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatBudget(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }
}
