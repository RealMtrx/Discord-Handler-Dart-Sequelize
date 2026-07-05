import 'package:nyxx/nyxx.dart';
import '../bot.dart';
import '../core/cooldown.dart';

class PrefixHandler {
  final Bot _bot;
  final CooldownManager _cooldown = CooldownManager();

  PrefixHandler(this._bot);

  Future<void> handle(IMessage message) async {
    if (message.author is! IUser || message.author.id == _bot.client.self.id) return;

    final content = message.content;
    final prefix = _bot.config.prefix;
    if (!content.startsWith(prefix)) return;

    final args = content.substring(prefix.length).trim().split(RegExp(r'\s+'));
    final commandName = args.first.toLowerCase();
    final cmdArgs = args.length > 1 ? args.sublist(1) : <String>[];

    final command = _bot.commandHandler.getPrefix(commandName);
    if (command == null) return;

    final userId = message.author.id.toString();
    if (_cooldown.isOnCooldown(userId, commandName)) {
      final remaining = _cooldown.getRemaining(userId, commandName);
      await message.channel.sendMessage(
        content: 'Please wait ${remaining.toStringAsFixed(1)}s before using this command again.',
      );
      return;
    }

    _cooldown.set(userId, commandName, command.cooldown);

    try {
      await command.execute(message, cmdArgs, _bot);
    } catch (e) {
      await message.channel.sendMessage(content: 'An error occurred while executing that command.');
    }
  }
}
