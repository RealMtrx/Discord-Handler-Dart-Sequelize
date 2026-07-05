import 'package:nyxx/nyxx.dart';
import '../bot.dart';
import '../handlers/logger.dart';

void onGuildDelete(IGuild guild, Bot bot) {
  Logger.warn('Left guild: ${guild.name} (${guild.id})');
}
