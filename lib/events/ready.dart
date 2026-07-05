import 'package:nyxx/nyxx.dart';
import '../bot.dart';
import '../handlers/logger.dart';

void onReady(INyxx client, Bot bot) {
  Logger.info('Logged in as ${client.self.tag} (${client.self.id})');
  Logger.info('Guilds: ${client.guilds.length}');
}
