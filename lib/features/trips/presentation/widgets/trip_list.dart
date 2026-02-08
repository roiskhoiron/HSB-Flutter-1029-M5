import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/presentation/dtos/trip_dto.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_card.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;
  final Function(Trip) onTripTap;
  final Function(Trip) onEdit;
  final Function(Trip) onDelete;

  const TripList({
    super.key,
    required this.trips,
    required this.onTripTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final trip = trips[index];
        return TripCard(
          trip: TripDto(trip),
          onTap: () => onTripTap(trip),
          onEdit: () => onEdit(trip),
          onDelete: () => onDelete(trip),
        );
      },
    );
  }
}
