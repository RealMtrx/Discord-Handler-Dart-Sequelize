import 'package:nyxx/nyxx.dart';
import '../bot.dart';

void onMessageCreate(IMessage message, Bot bot) {
  bot.prefixHandler.handle(message);
}
