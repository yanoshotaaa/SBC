import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      print('${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  static void error(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      print('${tag != null ? '[$tag] ' : ''}ERROR: $message');
      if (error != null) {
        print('Error details: $error');
      }
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
  }
}
