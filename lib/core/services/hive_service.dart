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

      _isInitialized = true;
      AppLogger.getLogger('HiveService').info('Hive initialized successfully');
    } catch (e) {
      AppLogger.getLogger(
        'HiveService',
      ).severe('Failed to initialize Hive: $e');
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

  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception(
        'HiveService not initialized. Call HiveService.initialize() first.',
      );
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

    AppLogger.getLogger('HiveService').info('ALL HIVE DATA CLEARED');
  }

  static Future<void> logAllData() async {
    if (!_isInitialized) await initialize();

    final logger = AppLogger.getLogger('HiveService');
    logger.info('=== HIVE DATA DEBUG ===');

    final usersBox = Hive.box('users');
    logger.info('USERS (${usersBox.length}):');
    for (var key in usersBox.keys) {
      logger.info('  Key: $key, Value: ${usersBox.get(key)}');
    }

    final authBox = Hive.box<dynamic>('auth');
    logger.info('AUTH (${authBox.length}):');
    for (var key in authBox.keys) {
      logger.info('  Key: $key, Value: ${authBox.get(key)}');
    }

    final tripsBox = Hive.box<TripModel>('trips');
    logger.info('TRIPS (${tripsBox.length}):');
    for (var key in tripsBox.keys) {
      final trip = tripsBox.get(key);
      logger.info(
        '  Key: $key, Trip ID: ${trip?.id}, User ID: ${trip?.userId}, Title: ${trip?.title}',
      );
    }

    logger.info('========================');
  }
}
