import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/core/result/result.dart';

abstract class TripRepository {
  Future<Result<Trip>> createTrip(Trip trip, String userId);

  Future<Result<List<Trip>>> getAllTrips(String userId);

  Future<Result<Trip?>> getTripById(String id);

  Future<Result<void>> updateTrip(Trip trip);

  Future<Result<void>> deleteTrip(String id);

  Future<Result<List<Trip>>> searchTrips(
    String userId, {
    String? query,
    TripStatus? status,
    String? destination,
  });

  Future<Result<List<Trip>>> getTripsByStatus(String userId, TripStatus status);

  Future<Result<List<Trip>>> getTripsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
}
