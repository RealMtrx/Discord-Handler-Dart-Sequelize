import 'package:nyxx/nyxx.dart';
import '../../../core/command_utils.dart';
import '../../../bot.dart';

PrefixCommand pingCommand = PrefixCommand(
  name: 'ping',
  description: 'Replies with Pong!',
  cooldown: 5,
  execute: (IMessage message, List<String> args, Bot bot) async {
    final start = DateTime.now();
    final msg = await message.channel.sendMessage(content: 'Pinging...');
    final latency = DateTime.now().difference(start).inMilliseconds;
    await msg.edit(content: 'Pong! Latency: ${latency}ms');
  },
);
