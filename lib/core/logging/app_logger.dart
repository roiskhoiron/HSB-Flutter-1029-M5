import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Custom log types for layer-specific visualization in Talker
class UILog extends TalkerLog {
  UILog(String super.message);
  @override
  String get title => 'UI';
  @override
  AnsiPen get pen => AnsiPen()..cyan();
}

class DomainLog extends TalkerLog {
  DomainLog(String super.message);
  @override
  String get title => 'DOMAIN';
  @override
  AnsiPen get pen => AnsiPen()..magenta();
}

class DataLog extends TalkerLog {
  DataLog(String super.message);
  @override
  String get title => 'DATA';
  @override
  AnsiPen get pen => AnsiPen()..blue();
}

/// Centralized logging system using Talker.
/// 💎 Arsitektur Logger menggunakan `Talker` ini sangat canggih! 
/// Memisahkan log UI, Domain, dan Data dengan warna berbeda (AnsiPen) 
/// adalah standar debugging kelas atas. Awesome! 🚀🌈
class AppLogger {
  static final Talker _talker = TalkerFlutter.init(
    logger: TalkerLogger(
      settings: TalkerLoggerSettings(enableColors: true, maxLineWidth: 110),
      output: (message) => debugPrint(message),
    ),
    settings: TalkerSettings(
      enabled: true,
      useConsoleLogs: true,
      useHistory: true,
      maxHistoryItems: 1000,
    ),
  );

  static Talker get talker => _talker;

  static void initialize() {
    info('Logger initialized with Talker 🚀');
  }

  /// Log for the Presentation layer (UI events, Navigation)
  static void ui(String message, {String? tag}) {
    final msg = tag != null ? '[$tag] $message' : message;
    _talker.logCustom(UILog(msg));
  }

  /// Log for the Domain layer (Business logic, UseCases)
  static void domain(String message, {String? tag}) {
    final msg = tag != null ? '[$tag] $message' : message;
    _talker.logCustom(DomainLog(msg));
  }

  /// Log for the Data layer (Repository, Datasources, API calls)
  static void data(String message, {String? tag}) {
    final msg = tag != null ? '[$tag] $message' : message;
    _talker.logCustom(DataLog(msg));
  }

  /// Standard log levels with optional tags
  static void debug(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final msg = tag != null ? '[$tag] $message' : message;
    _talker.debug(msg, error, stackTrace);
  }

  static void info(String message, {String? tag}) {
    final msg = tag != null ? '[$tag] $message' : message;
    _talker.info(msg);
  }

  static void warning(String message, {String? tag}) {
    final msg = tag != null ? '[$tag] $message' : message;
    _talker.warning(msg);
  }

  static void error(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final msg = tag != null ? '[$tag] $message' : message;
    _talker.handle(error ?? msg, stackTrace, msg);
  }

  static void severe(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final msg = tag != null ? '[$tag] $message' : message;
    _talker.critical(msg, error, stackTrace);
  }
}
