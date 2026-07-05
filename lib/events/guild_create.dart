import 'package:nyxx/nyxx.dart';
import '../bot.dart';
import '../handlers/logger.dart';

void onGuildCreate(IGuild guild, Bot bot) {
  Logger.info('Joined guild: ${guild.name} (${guild.id})');
}
