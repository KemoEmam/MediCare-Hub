import 'package:logger/logger.dart';

class LogHelper {
  // Singleton instance of the logger
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to display
      errorMethodCount: 5, // Depth of error stack traces
      colors: true, // Enable colorful output
      printEmojis: true, // Enable emojis for log levels
      dateTimeFormat: DateTimeFormat
          .onlyTimeAndSinceStart, // Include timestamps in the logs
    ),
  );

  // Getter for the logger instance
  static Logger get logger => _logger;

  // Info log
  static void info(String message) {
    _logger.i(message);
  }

  // Warning log (modified to return the message)
  static String warning(String message) {
    _logger.w(message);
    return message; // Return the logged message
  }
}
