import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/domain/value_objects/destination.dart';
import 'package:travel_planner/features/trips/domain/value_objects/travel_date.dart';
import 'package:travel_planner/features/trips/domain/value_objects/money.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_form.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class TripDialogs {
  TripDialogs._();

  static void showAddTripDialog(
    BuildContext context,
    Function(Trip) onSave,
    String userId,
  ) {
    showDialog(
      context: context,
      builder: (context) => TripForm(
        onSave: (tripData) async {
          final trip = Trip(
            id: const Uuid().v4(),
            title: tripData['title'],
            description: tripData['description'],
            destination: Destination.restore(tripData['destination']),
            startDate: TravelDate.restore(tripData['startDate']),
            endDate: TravelDate.restore(tripData['endDate']),
            budget: Money.usd(tripData['budget']),
            status: tripData['status'] ?? TripStatus.planned,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            userId: userId,
          );
          await onSave(trip);
        },
      ),
    );
  }

  static void showEditTripDialog(
    BuildContext context,
    Trip trip,
    Function(Trip) onSave,
  ) {
    showDialog(
      context: context,
      builder: (context) => TripForm(
        trip: trip,
        onSave: (tripData) async {
          final updatedTrip = trip.copyWith(
            title: tripData['title'],
            description: tripData['description'],
            destination: Destination.restore(tripData['destination']),
            startDate: TravelDate.restore(tripData['startDate']),
            endDate: TravelDate.restore(tripData['endDate']),
            budget: Money.usd(tripData['budget']),
            status: tripData['status'] ?? trip.status,
            updatedAt: DateTime.now(),
          );
          await onSave(updatedTrip);
        },
      ),
    );
  }

  static Future<void> showDeleteConfirmation(
    BuildContext context,
    Trip trip,
    Function(Trip) onDelete, {
    bool isOnDetailScreen = false,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(dialogContext).deleteTrip),
        content: Text(
          AppLocalizations.of(dialogContext).deleteTripConfirmation(trip.title),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(AppLocalizations.of(dialogContext).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              AppLocalizations.of(dialogContext).delete,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (isOnDetailScreen && context.mounted) {
        context.pop();
      }
      await onDelete(trip);
    }
  }
}
