import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/di/service_locator.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/domain/usecases/trip_usecases.dart';

final tripUseCasesProvider = Provider<TripUseCases>((ref) {
  return serviceLocator<TripUseCases>();
});

final tripsProvider = AsyncNotifierProvider<TripNotifier, List<Trip>>(
  TripNotifier.new,
);

final tripOperationProvider = StateProvider.autoDispose<AsyncValue<void>>(
  (ref) => const AsyncData(null),
);

// 💎 `TripNotifier` mendemonstrasikan integrasi Riverpod 2.0 yang sangat matang. 
// Penggunaan `AsyncNotifier` membuat handling loading & error jadi jauh lebih elegan! ⚡🏗️
class TripNotifier extends AsyncNotifier<List<Trip>> {
  late TripUseCases _useCases;

  @override
  FutureOr<List<Trip>> build() async {
    _useCases = ref.watch(tripUseCasesProvider);
    final user = ref.watch(authNotifierProvider).value;

    if (user == null) return [];

    final result = await _useCases.getAllTrips(user.id);
    if (result.isSuccess) {
      final trips = result.value!;
      trips.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return trips;
    }
    throw Exception(result.error?.message ?? 'Failed to load trips');
  }

  Future<void> addTrip(Trip trip) async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    final operation = ref.read(tripOperationProvider.notifier);
    operation.state = const AsyncLoading();

    final previousState = await future;
    state = AsyncData([trip, ...previousState]);

    final result = await _useCases.createTrip(trip, user.id);
    if (result.isFailure) {
      state = AsyncData(previousState);
      operation.state = AsyncError(
        result.error?.message ?? 'Failed to add trip',
        StackTrace.current,
      );
    } else {
      operation.state = const AsyncData(null);
    }
  }

  Future<void> updateTrip(Trip trip) async {
    final operation = ref.read(tripOperationProvider.notifier);
    operation.state = const AsyncLoading();

    final previousState = await future;
    state = AsyncData(
      previousState.map((t) => t.id == trip.id ? trip : t).toList(),
    );

    final result = await _useCases.updateTrip(trip);
    if (result.isFailure) {
      state = AsyncData(previousState);
      operation.state = AsyncError(
        result.error?.message ?? 'Failed to update trip',
        StackTrace.current,
      );
    } else {
      operation.state = const AsyncData(null);
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    final operation = ref.read(tripOperationProvider.notifier);
    operation.state = const AsyncLoading();

    final previousState = await future;
    state = AsyncData(previousState.where((t) => t.id != trip.id).toList());

    final result = await _useCases.deleteTrip(trip.id);
    if (result.isFailure) {
      state = AsyncData(previousState);
      operation.state = AsyncError(
        result.error?.message ?? 'Failed to delete trip',
        StackTrace.current,
      );
    } else {
      operation.state = const AsyncData(null);
    }
  }

  Future<void> refetch() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }
}
