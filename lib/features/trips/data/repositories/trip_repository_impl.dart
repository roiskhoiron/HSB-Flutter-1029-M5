import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/data/models/trip_model.dart';
import 'package:travel_planner/features/trips/domain/repositories/trip_repository.dart';
import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/core/logging/app_logger.dart';

class TripRepositoryImpl implements TripRepository {
  final Box<TripModel> _tripsBox;

  TripRepositoryImpl({required Box<TripModel> tripsBox}) : _tripsBox = tripsBox;

  @override
  Future<Result<Trip>> createTrip(Trip trip, String userId) async {
    try {
      final tripModel = TripModel.fromDomain(trip, userId);
      await _tripsBox.put(trip.id, tripModel);

      AppLogger.data('Trip created: ${trip.id}');
      return Result.success(trip);
    } catch (e) {
      AppLogger.error('Failed to create trip: $e', tag: 'TripRepository');
      return Result.failure(
        DataError('Failed to create trip: $e', 'CREATE_TRIP_FAILED'),
      );
    }
  }

  @override
  Future<Result<List<Trip>>> getAllTrips(String userId) async {
    try {
      final allTrips = _tripsBox.values.toList();
      final trips = allTrips
          .where((model) => model.userId == userId)
          .map((model) => model.toDomain())
          .toList();
      AppLogger.data(
        'Filtered trips for user $userId: ${trips.length}',
        tag: 'TripRepository',
      );
      return Result.success(trips);
    } catch (e) {
      AppLogger.error('Failed to get trips: $e', tag: 'TripRepository');
      return Result.failure(
        DataError('Failed to get trips: $e', 'GET_TRIPS_FAILED'),
      );
    }
  }

  @override
  Future<Result<Trip?>> getTripById(String id) async {
    try {
      final tripModel = _tripsBox.get(id);
      return Result.success(tripModel?.toDomain());
    } catch (e) {
      AppLogger.error('Failed to get trip by id: $id', tag: 'TripRepository');
      return Result.failure(
        DataError('Failed to get trip: $e', 'GET_TRIP_BY_ID_FAILED'),
      );
    }
  }

  @override
  Future<Result<void>> updateTrip(Trip trip) async {
    try {
      if (!_tripsBox.containsKey(trip.id)) {
        return Result.failure(
          NotFoundError('Trip not found: ${trip.id}', 'TRIP_NOT_FOUND'),
        );
      }

      await _tripsBox.put(trip.id, TripModel.fromDomain(trip, trip.userId));

      AppLogger.data('Trip updated: ${trip.id}');
      return Result.success(null);
    } catch (e) {
      AppLogger.error('Failed to update trip: $e', tag: 'TripRepository');
      return Result.failure(
        DataError('Failed to update trip: $e', 'UPDATE_TRIP_FAILED'),
      );
    }
  }

  @override
  Future<Result<void>> deleteTrip(String id) async {
    try {
      await _tripsBox.delete(id);
      AppLogger.data('Trip deleted: $id');
      return Result.success(null);
    } catch (e) {
      AppLogger.error('Failed to delete trip: $e', tag: 'TripRepository');
      return Result.failure(
        DataError('Failed to delete trip: $e', 'DELETE_TRIP_FAILED'),
      );
    }
  }

  @override
  Future<Result<List<Trip>>> searchTrips(
    String userId, {
    String? query,
    TripStatus? status,
    String? destination,
  }) async {
    try {
      final allTripsResult = await getAllTrips(userId);
      if (allTripsResult.isFailure) return allTripsResult;

      final trips = allTripsResult.value!.where((trip) {
        final matchesQuery =
            query == null ||
            trip.title.toLowerCase().contains(query.toLowerCase()) ||
            trip.description.toLowerCase().contains(query.toLowerCase());
        final matchesStatus = status == null || trip.status == status;
        final matchesDestination =
            destination == null ||
            trip.destination.value.toLowerCase().contains(
              destination.toLowerCase(),
            );

        return matchesQuery && matchesStatus && matchesDestination;
      }).toList();

      return Result.success(trips);
    } catch (e) {
      AppLogger.error('Failed to search trips: $e', tag: 'TripRepository');
      return Result.failure(
        DataError('Failed to search trips: $e', 'SEARCH_TRIPS_FAILED'),
      );
    }
  }

  @override
  Future<Result<List<Trip>>> getTripsByStatus(
    String userId,
    TripStatus status,
  ) async {
    try {
      final allTripsResult = await getAllTrips(userId);
      if (allTripsResult.isFailure) return allTripsResult;

      final filteredTrips = allTripsResult.value!
          .where((trip) => trip.status == status)
          .toList();
      return Result.success(filteredTrips);
    } catch (e) {
      AppLogger.error(
        'Failed to get trips by status: $e',
        tag: 'TripRepository',
      );
      return Result.failure(
        DataError(
          'Failed to get trips by status: $e',
          'GET_TRIPS_BY_STATUS_FAILED',
        ),
      );
    }
  }

  @override
  Future<Result<List<Trip>>> getTripsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final allTripsResult = await getAllTrips(userId);
      if (allTripsResult.isFailure) return allTripsResult;

      final filteredTrips = allTripsResult.value!.where((trip) {
        final date = trip.startDate.value;
        //{Inline Review: Perbandingan eksklusif ini mengecualikan tanggal batas range; pertimbangkan inclusive boundary.}
        return date.isAfter(startDate) && date.isBefore(endDate);
      }).toList();

      return Result.success(filteredTrips);
    } catch (e) {
      AppLogger.error(
        'Failed to get trips by date range: $e',
        tag: 'TripRepository',
      );
      return Result.failure(
        DataError(
          'Failed to get trips by date range: $e',
          'GET_TRIPS_BY_DATE_RANGE_FAILED',
        ),
      );
    }
  }
}
