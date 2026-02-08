import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

enum LogLevel {
  debug(0, 'DEBUG'),
  info(1, 'INFO'),
  warning(2, 'WARNING'),
  error(3, 'ERROR'),
  severe(4, 'SEVERE');

  const LogLevel(this.value, this.name);
  final int value;
  final String name;
}

class LogEntry {
  final DateTime timestamp;
  final LogLevel level;
  final String loggerName;
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? metadata;
  LogEntry({
    required this.timestamp,
    required this.level,
    required this.loggerName,
    required this.message,
    this.error,
    this.stackTrace,
    this.metadata,
  });
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'level': level.name,
      'logger': loggerName,
      'message': message,
      'error': error?.toString(),
      'stackTrace': stackTrace?.toString(),
      'metadata': metadata,
    };
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write('${level.name.padRight(7)} ');
    buffer.write('${timestamp.toIso8601String()} ');
    buffer.write('[$loggerName] ');
    buffer.write(message);

    if (error != null) {
      buffer.write('\nError: $error');
    }

    if (stackTrace != null) {
      buffer.write('\nStack trace:\n$stackTrace');
    }

    return buffer.toString();
  }
}

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();
  final Map<String, Logger> _loggers = {};
  LogLevel _currentLevel = kDebugMode ? LogLevel.debug : LogLevel.info;
  bool _initialized = false;
  final List<LogEntry> _logBuffer = [];
  final int _maxBufferSize = 1000;
  static void initialize({
    LogLevel? level,
    bool enableFileLogging = false,
    String? logDirectory,
  }) {
    _instance._initialize(
      level: level,
      enableFileLogging: enableFileLogging,
      logDirectory: logDirectory,
    );
  }

  void _initialize({
    LogLevel? level,
    bool enableFileLogging = false,
    String? logDirectory,
  }) {
    if (_initialized) return;
    _currentLevel = level ?? (kDebugMode ? LogLevel.debug : LogLevel.info);

    Logger.root.level = _mapLogLevel(_currentLevel);

    Logger.root.onRecord.listen((record) {
      final logEntry = LogEntry(
        timestamp: record.time,
        level: _mapLogEntryLevel(record.level),
        loggerName: record.loggerName,
        message: record.message,
        error: record.error,
        stackTrace: record.stackTrace,
      );
      _processLogEntry(logEntry, enableFileLogging, logDirectory);
    });
    _initialized = true;
    getLogger(
      'AppLogger',
    ).info('Logger initialized with level: $_currentLevel');
  }

  void _processLogEntry(
    LogEntry entry,
    bool enableFileLogging,
    String? logDirectory,
  ) {
    if (kDebugMode) {
      log(entry.toString());
    } else {
      if (entry.level.value >= LogLevel.warning.value) {
        log(entry.toString());
      }
    }

    _logBuffer.add(entry);
    if (_logBuffer.length > _maxBufferSize) {
      _logBuffer.removeAt(0);
    }

    if (enableFileLogging && logDirectory != null) {
      _writeToFile(entry, logDirectory);
    }
  }

  Future<void> _writeToFile(LogEntry entry, String logDirectory) async {
    try {
      final logDir = Directory(logDirectory);
      if (!logDir.existsSync()) {
        await logDir.create(recursive: true);
      }
      final today = DateTime.now();
      final fileName =
          'app_${today.year}_${today.month.toString().padLeft(2, '0')}_${today.day.toString().padLeft(2, '0')}.log';
      final logFile = File(path.join(logDirectory, fileName));
      final logLine = '${entry.toJson()}\n';
      await logFile.writeAsString(logLine, mode: FileMode.append);
    } catch (e) {
      log('Failed to write log to file: $e');
    }
  }

  static Logger getLogger(String name) {
    _instance._initializeIfNotDone();
    return _instance._loggers.putIfAbsent(name, () => Logger(name));
  }

  void _initializeIfNotDone() {
    if (!_initialized) {
      initialize();
    }
  }

  void setLogLevel(LogLevel level) {
    _currentLevel = level;
    Logger.root.level = _mapLogLevel(level);
    getLogger('AppLogger').info('Log level changed to: $level');
  }

  List<LogEntry> getLogBuffer() => List.unmodifiable(_logBuffer);

  void clearLogBuffer() {
    _logBuffer.clear();
    getLogger('AppLogger').info('Log buffer cleared');
  }

  List<LogEntry> getLogsByLevel(LogLevel level) {
    return _logBuffer.where((entry) => entry.level == level).toList();
  }

  List<LogEntry> getLogsByLogger(String loggerName) {
    return _logBuffer.where((entry) => entry.loggerName == loggerName).toList();
  }

  List<LogEntry> getLogsInTimeRange(DateTime start, DateTime end) {
    return _logBuffer
        .where(
          (entry) =>
              entry.timestamp.isAfter(start) && entry.timestamp.isBefore(end),
        )
        .toList();
  }

  void logStructured(
    LogLevel level,
    String loggerName,
    String message, {
    Map<String, dynamic>? metadata,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final logger = getLogger(loggerName);

    final record = LogRecord(
      _mapLogLevel(level),
      message,
      loggerName,
      error,
      stackTrace,
    );

    final logEntry = LogEntry(
      timestamp: record.time,
      level: level,
      loggerName: loggerName,
      message: message,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );

    _processLogEntry(logEntry, false, null);
    logger.log(record.level, record.message, record.error, record.stackTrace);
  }

  static Level _mapLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Level.FINE;
      case LogLevel.info:
        return Level.INFO;
      case LogLevel.warning:
        return Level.WARNING;
      case LogLevel.error:
        return Level.SEVERE;
      case LogLevel.severe:
        return Level.SHOUT;
    }
  }

  static LogLevel _mapLogEntryLevel(Level level) {
    if (level <= Level.FINE) return LogLevel.debug;
    if (level <= Level.INFO) return LogLevel.info;
    if (level <= Level.WARNING) return LogLevel.warning;
    if (level <= Level.SEVERE) return LogLevel.error;
    return LogLevel.severe;
  }

  static void debug(
    String message, {
    String? loggerName,
    Map<String, dynamic>? metadata,
  }) {
    _instance.logStructured(
      LogLevel.debug,
      loggerName ?? 'App',
      message,
      metadata: metadata,
    );
  }

  static void info(
    String message, {
    String? loggerName,
    Map<String, dynamic>? metadata,
  }) {
    _instance.logStructured(
      LogLevel.info,
      loggerName ?? 'App',
      message,
      metadata: metadata,
    );
  }

  static void warning(
    String message, {
    String? loggerName,
    Map<String, dynamic>? metadata,
  }) {
    _instance.logStructured(
      LogLevel.warning,
      loggerName ?? 'App',
      message,
      metadata: metadata,
    );
  }

  static void error(
    String message, {
    String? loggerName,
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _instance.logStructured(
      LogLevel.error,
      loggerName ?? 'App',
      message,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );
  }

  static void severe(
    String message, {
    String? loggerName,
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _instance.logStructured(
      LogLevel.severe,
      loggerName ?? 'App',
      message,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );
  }
}
