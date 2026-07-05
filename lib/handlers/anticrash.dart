import 'dart:async';
import 'dart:io';
import '../core/webhooks.dart';

class AntiCrash {
  static void setup() {
    runZonedGuarded(() {
      _handleErrors();
    }, (Object error, StackTrace stack) {
      _logError(error, stack);
    });
  }

  static void _handleErrors() {
    Platform.setUnhandledExceptionReporter((exception, stackTrace) {
      _logError(exception, stackTrace);
    });
  }

  static Future<void> _logError(Object error, StackTrace stack) async {
    final message = '**AntiCrash Caught Error:**\n```\n$error\n\n$stack\n```';
    await Webhooks.sendError(message);
  }
}
