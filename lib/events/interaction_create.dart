import 'package:nyxx/nyxx.dart';
import '../bot.dart';
import '../core/cooldown.dart';

final CooldownManager _interactionCooldown = CooldownManager();

Future<void> onInteractionCreate(IInteraction interaction, Bot bot) async {
  if (interaction is IChatInteraction) {
    final commandName = interaction.commandName;
    final userId = interaction.user.id.toString();

    final command = bot.commandHandler.getSlash(commandName);
    if (command == null) {
      await interaction.respond(
        content: 'Command not found.',
        level: InteractionResponseLevel.channelMessageWithSource,
      );
      return;
    }

    final cooldown = 3;
    if (_interactionCooldown.isOnCooldown(userId, commandName)) {
      final remaining = _interactionCooldown.getRemaining(userId, commandName);
      await interaction.respond(
        content: 'Please wait ${remaining.toStringAsFixed(1)}s before using this command again.',
        level: InteractionResponseLevel.channelMessageWithSource,
      );
      return;
    }

    _interactionCooldown.set(userId, commandName, cooldown);

    await interaction.respond(
      content: 'Pong!',
      level: InteractionResponseLevel.channelMessageWithSource,
    );
  }
}
