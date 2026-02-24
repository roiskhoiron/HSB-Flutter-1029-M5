import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:travel_planner/features/auth/data/models/user_model.dart';
import 'package:travel_planner/features/trips/data/models/trip_model.dart';
import 'package:travel_planner/hive_registrar.g.dart';
import 'package:travel_planner/core/logging/app_logger.dart';

class HiveService {
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await Hive.initFlutter();
      Hive.registerAdapters();

      await Hive.openBox<UserModel>('users');
      await Hive.openBox<TripModel>('trips');
      await Hive.openBox<dynamic>('auth');
      await Hive.openBox<Map>('trip_notes');

      _isInitialized = true;
      AppLogger.info('Hive initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize Hive: $e', tag: 'HiveService');
      rethrow;
    }
  }

  static Box<UserModel> getUsersBox() {
    _ensureInitialized();
    return Hive.box<UserModel>('users');
  }

  static Box<TripModel> getTripsBox() {
    _ensureInitialized();
    return Hive.box<TripModel>('trips');
  }

  static Box<dynamic> getAuthBox() {
    _ensureInitialized();
    return Hive.box('auth');
  }

  static Box<Map> getTripNotesBox() {
    _ensureInitialized();
    return Hive.box<Map>('trip_notes');
  }

  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('HiveService not initialized');
    }
  }

  static Future<void> dispose() async {
    await Hive.close();
    _isInitialized = false;
  }

  static Future<void> clearAllData() async {
    if (!_isInitialized) await initialize();

    await Hive.box('users').clear();
    await Hive.box<TripModel>('trips').clear();
    await Hive.box<dynamic>('auth').clear();

    AppLogger.data('All Hive boxes cleared', tag: 'HiveService');
  }

  static Future<void> logAllData() async {
    if (!_isInitialized) await initialize();

    final usersBox = Hive.box<UserModel>('users');
    AppLogger.data('USERS (${usersBox.length}):');
    for (var key in usersBox.keys) {
      final user = usersBox.get(key);
      //{Inline Review: Jangan log password plaintext di environment mana pun, termasuk debug log.}
      AppLogger.data(
        '  Key: $key, Email: ${user?.email}, PW: ${user?.password}, Name: ${user?.name}',
      );
    }

    final authBox = Hive.box<dynamic>('auth');
    AppLogger.data('AUTH (${authBox.length}):');
    for (var key in authBox.keys) {
      AppLogger.data('  Key: $key, Value: ${authBox.get(key)}');
    }

    final tripsBox = Hive.box<TripModel>('trips');
    AppLogger.data('TRIPS (${tripsBox.length}):');
    for (var key in tripsBox.keys) {
      final trip = tripsBox.get(key);
      AppLogger.data(
        '  Key: $key, Trip ID: ${trip?.id}, User ID: ${trip?.userId}, Title: ${trip?.title}',
      );
    }

    AppLogger.data('========================');
  }
}
