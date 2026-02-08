import 'package:flutter/foundation.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/domain/usecases/trip_usecases.dart';

class TripViewModel extends ChangeNotifier {
  final TripUseCases _useCases;
  String _userId;

  List<Trip> _allTrips = [];
  bool _isLoading = false;
  String? _error;
  final String _searchQuery = '';
  TripStatus? _selectedStatus;

  TripViewModel({required TripUseCases useCases, required String userId})
    : _useCases = useCases,
      _userId = userId;

  String get userId => _userId;

  void updateUserId(String newUserId) {
    if (_userId == newUserId) return;
    _userId = newUserId;
    if (_userId.isNotEmpty) {
      loadTrips();
    } else {
      _allTrips = [];
      notifyListeners();
    }
  }

  List<Trip> get allTrips => _allTrips;
  List<Trip> get recentTrips =>
      List.from(_allTrips)..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  TripStatus? get selectedStatus => _selectedStatus;

  List<Trip> getTripsByStatus(TripStatus status) {
    return _allTrips.where((t) => t.status == status).toList();
  }

  Future<void> loadTrips() async {
    _setLoading(true);
    _error = null;

    final result = await _useCases.getAllTrips(userId);
    if (result.isSuccess) {
      _allTrips = result.value!;
    } else {
      _error = result.error?.message ?? 'Failed to load trips';
    }
    _setLoading(false);
  }

  Future<void> addTrip(Trip trip) async {
    // Optimistic Update: Add to list immediately
    _allTrips.add(trip);
    notifyListeners();

    final result = await _useCases.createTrip(trip, userId);

    if (result.isFailure) {
      // Rollback on failure
      _allTrips.removeWhere((t) => t.id == trip.id);
      _error = result.error?.message;
      notifyListeners();
    }
  }

  Future<void> updateTrip(Trip trip) async {
    final index = _allTrips.indexWhere((t) => t.id == trip.id);
    if (index == -1) return;

    final oldTrip = _allTrips[index];
    // Optimistic Update
    _allTrips[index] = trip;
    notifyListeners();

    final result = await _useCases.updateTrip(trip);

    if (result.isFailure) {
      // Rollback on failure
      _allTrips[index] = oldTrip;
      _error = result.error?.message;
      notifyListeners();
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    final index = _allTrips.indexWhere((t) => t.id == trip.id);
    if (index == -1) return;

    final deletedTrip = _allTrips[index];
    // Optimistic Update
    _allTrips.removeAt(index);
    notifyListeners();

    final result = await _useCases.deleteTrip(trip.id);

    if (result.isFailure) {
      // Rollback on failure
      _allTrips.insert(index, deletedTrip);
      _error = result.error?.message;
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
