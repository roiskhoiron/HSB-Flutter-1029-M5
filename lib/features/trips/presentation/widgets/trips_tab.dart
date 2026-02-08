import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/presentation/controllers/trip_view_model.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_list.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_dialogs.dart';
import 'package:travel_planner/shared/widgets/states/app_loading_state.dart';
import 'package:travel_planner/shared/widgets/states/app_error_state.dart';
import 'package:travel_planner/shared/widgets/states/app_empty_state.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart'; // Ensure context.l10n is available

class TripsTab extends StatefulWidget {
  final TripStatus status;

  const TripsTab({super.key, required this.status});

  @override
  State<TripsTab> createState() => _TripsTabState();
}

class _TripsTabState extends State<TripsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = context.watch<TripViewModel>();
    final trips = viewModel.getTripsByStatus(widget.status);

    if (viewModel.isLoading && trips.isEmpty) {
      return const AppLoadingState();
    }

    if (viewModel.error != null && trips.isEmpty) {
      return AppErrorState(
        message: viewModel.error!,
        onRetry: viewModel.loadTrips,
      );
    }

    if (trips.isEmpty) {
      return AppEmptyState(
        title: context.l10n.noTrips,
        message: context.l10n.startPlanning,
        retryLabel: context.l10n.addTrip,
        onRetry: () => TripDialogs.showAddTripDialog(
          context,
          viewModel.addTrip,
          viewModel.userId,
        ),
      );
    }

    return TripList(
      trips: trips,
      onTripTap: (trip) => context.pushNamed(
        AppRoutes.tripDetail,
        pathParameters: {'id': trip.id},
      ),
      onEdit: (trip) {
        TripDialogs.showEditTripDialog(context, trip, (updatedTrip) async {
          await viewModel.updateTrip(updatedTrip);
        });
      },
      onDelete: (trip) {
        TripDialogs.showDeleteConfirmation(context, trip, (deletedTrip) async {
          await viewModel.deleteTrip(deletedTrip);
        });
      },
    );
  }
}
