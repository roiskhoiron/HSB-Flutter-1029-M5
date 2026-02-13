import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_notifier.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trips_tab.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trips_app_bar.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_statistics.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_dialogs.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';

import 'package:travel_planner/shared/widgets/app_background_gradient.dart';

// 💎 `TripsScreen` yang menggunakan `ConsumerStatefulWidget` dengan 
// `TabController` untuk navigasi status Trip adalah implementasi yang sangat solid! 🗺️🚀
class TripsScreen extends ConsumerStatefulWidget {
  const TripsScreen({super.key});

  @override
  ConsumerState<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends ConsumerState<TripsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: TripStatus.values.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tripsState = ref.watch(tripsProvider);

    return Stack(
      children: [
        const Positioned.fill(
          child: AppBackgroundGradient(
            direction: GradientDirection.topToBottom,
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: TripsAppBar(tabController: _tabController),
          body: SafeArea(
            bottom: false,
            child: tripsState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (trips) => Column(
                spacing: 0,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TripStatistics(trips: trips),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: TripStatus.values
                          .map((s) => TripsTab(status: s))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: const Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: _AddTripButton(),
          ),
        ),
      ],
    );
  }
}

class _AddTripButton extends ConsumerWidget {
  const _AddTripButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).value;
    final tripNotifier = ref.read(tripsProvider.notifier);

    return FloatingActionButton(
      onPressed: () => TripDialogs.showAddTripDialog(
        context,
        tripNotifier.addTrip,
        user?.id ?? '',
      ),
      child: const Icon(Icons.add),
    );
  }
}
