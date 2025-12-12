import 'package:logger/logger.dart';

/// EWA Kit Logging Utility
///
/// Provides colored logging with different levels for debugging and monitoring
/// application behavior.
///
/// Example usage:
/// ```dart
/// EwaLogger.info('User logged in successfully');
/// EwaLogger.error('Failed to load data', error: e, stackTrace: s);
/// EwaLogger.warn('Low memory warning');
/// EwaLogger.debug('Processing user data');
/// ```
class EwaLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: Level.trace,
  );

  /// Logs a debug message (white)
  static void debug(String message) {
    _logger.d(message);
  }

  /// Logs an informational message (blue)
  static void info(String message) {
    _logger.i(message);
  }

  /// Logs a warning message (yellow)
  static void warn(String message) {
    _logger.w(message);
  }

  /// Logs an error message (red)
  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Logs a trace message (gray)
  static void trace(String message) {
    _logger.t(message);
  }

  /// Logs a fatal/critical error (bright red)
  static void fatal(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
