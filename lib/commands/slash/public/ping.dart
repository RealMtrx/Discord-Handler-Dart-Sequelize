import 'package:nyxx/nyxx.dart';
import '../../../core/command_utils.dart';
import '../../../bot.dart';

SlashCommandBuilder pingCommand = createSlashCommand(
  'ping',
  'Replies with Pong!',
);

Future<void> executePing(INyxx client, Bot bot) async {
  // Handled in interaction_create.dart
}
