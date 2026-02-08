import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class TripsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const TripsAppBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return AppBar(
      title: Text(loc.yourTrips),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => context.goNamed(AppRoutes.home),
      ),
      bottom: TabBar(
        controller: tabController,
        tabs: TripStatus.values.map((s) => Tab(text: _label(s, loc))).toList(),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  String _label(TripStatus s, AppLocalizations loc) => switch (s) {
    TripStatus.planned => loc.planned,
    TripStatus.upcoming => loc.ongoing,
    TripStatus.completed => loc.completed,
  }.toUpperCase();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
