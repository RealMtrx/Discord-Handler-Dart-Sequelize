import 'dart:io';

class Logger {
  static final DateTime _start = DateTime.now();

  static void info(String message) {
    _log('INFO', message);
  }

  static void warn(String message) {
    _log('WARN', message);
  }

  static void error(String message) {
    _log('ERROR', message);
  }

  static void debug(String message) {
    _log('DEBUG', message);
  }

  static void _log(String level, String message) {
    final timestamp = DateTime.now().toIso8601String();
    final elapsed = DateTime.now().difference(_start).inMilliseconds;
    final line = '[$timestamp] [$level] [$elapsed ms] $message';
    stdout.writeln(line);
  }
}
