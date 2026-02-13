import 'package:flutter/material.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/core/di/service_locator.dart';

// 💎 Abstraksi inisialisasi aplikasi ke dalam `AppInitializer` adalah praktik 
// yang sangat bersih untuk menjaga `main.dart` tetap ramping. Arsitektur yang solid! 🚀🏗️
class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    AppLogger.initialize();
    AppLogger.info('Starting app initialization...');

    await setupServiceLocator();

    AppLogger.info('App initialization completed.');
  }
}
