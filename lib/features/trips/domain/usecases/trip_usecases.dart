import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/domain/repositories/trip_repository.dart';

class TripUseCases {
  final TripRepository _repository;

  const TripUseCases(this._repository);

  Future<Result<List<Trip>>> getAllTrips(String userId) async {
    return _repository.getAllTrips(userId);
  }

  Future<Result<Trip>> createTrip(Trip trip, String userId) async {
    return _repository.createTrip(trip, userId);
  }

  Future<Result<Trip?>> getTripById(String id) async {
    return _repository.getTripById(id);
  }

  Future<Result<void>> updateTrip(Trip trip) async {
    return _repository.updateTrip(trip);
  }

  Future<Result<void>> deleteTrip(String tripId) async {
    return _repository.deleteTrip(tripId);
  }

  Future<Result<List<Trip>>> getRecentTrips(String userId) async {
    final result = await _repository.getAllTrips(userId);
    if (result.isFailure) return result;

    final recent = result.value!
        .where((trip) => trip.isUpcoming)
        .take(5)
        .toList();
    return Result.success(recent);
  }
}
