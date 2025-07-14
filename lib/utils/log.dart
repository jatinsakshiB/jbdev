import 'package:flutter/foundation.dart';

class Log {
  static const String reset = '\x1B[0m';

  static void log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }

  // Error log (red)
  static void e(Object message) {
    log('\x1B[31m$message$reset');
  }

  // Warning log (yellow)
  static void w(Object message) {
    log('\x1B[33m$message$reset');
  }

  // Info log (blue)
  static void i(Object message) {
    log('\x1B[34m$message$reset');
  }

  // Success log (green)
  static void s(Object message) {
    log('\x1B[32m$message$reset');
  }

  // Debug log (cyan)
  static void d(Object message) {
    log('\x1B[36m$message$reset');
  }
}
