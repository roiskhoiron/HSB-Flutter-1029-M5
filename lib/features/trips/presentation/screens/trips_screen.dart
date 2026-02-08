import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/presentation/controllers/trip_view_model.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trips_tab.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trips_app_bar.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_statistics.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_dialogs.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen>
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
    final viewModel = context.watch<TripViewModel>();

    return Scaffold(
      appBar: TripsAppBar(tabController: _tabController),
      body: Column(
        spacing: 0,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TripStatistics(trips: viewModel.allTrips),
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
      floatingActionButton: _AddTripButton(viewModel: viewModel),
    );
  }
}

class _AddTripButton extends StatelessWidget {
  final TripViewModel viewModel;
  
  const _AddTripButton({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          TripDialogs.showAddTripDialog(context, viewModel.addTrip, viewModel.userId),
      child: const Icon(Icons.add),
    );
  }
}
