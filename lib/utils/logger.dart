import 'package:logger/logger.dart';

/// Global logger instance for the application
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
  level: Level.debug,
);

/// Log a message without stack trace
void logNoStack(String message, {Level level = Level.debug}) {
  Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  ).log(level, message);
}

/// Extension methods for easier logging
extension LoggerExtension on Logger {
  /// Log a debug message with optional error and stack trace
  void debug(String message, {dynamic error, StackTrace? stackTrace}) {
    d(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log an info message with optional error and stack trace
  void info(String message, {dynamic error, StackTrace? stackTrace}) {
    i(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log a warning message with optional error and stack trace
  void warning(String message, {dynamic error, StackTrace? stackTrace}) {
    w(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log an error message with optional error and stack trace
  void error(String message, {dynamic error, StackTrace? stackTrace}) {
    e(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log a fatal message with optional error and stack trace
  void fatal(String message, {dynamic error, StackTrace? stackTrace}) {
    f(message, error: error, stackTrace: stackTrace);
  }
}