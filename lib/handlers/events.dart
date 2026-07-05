import 'dart:io';
import 'package:nyxx/nyxx.dart';
import '../bot.dart';
import 'logger.dart';

class EventHandler {
  final Map<String, void Function(INyxx, Bot)> _events = {};

  void register(String name, void Function(INyxx, Bot) handler) {
    _events[name] = handler;
  }

  void call(String name, INyxx client, Bot bot) {
    final handler = _events[name];
    if (handler != null) {
      handler(client, bot);
    }
  }

  Future<void> loadEvents(Bot bot) async {
    final dir = Directory('lib/events');
    if (await dir.exists()) {
      final files = dir.listSync().whereType<File>().toList();
      for (final file in files) {
        final name = file.uri.pathSegments.last.replaceAll('.dart', '');
        Logger.info('Loaded event: $name');
      }
    }
  }
}
