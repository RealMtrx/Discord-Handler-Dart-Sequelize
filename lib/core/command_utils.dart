import 'package:nyxx/nyxx.dart';
import '../bot.dart';

class PrefixCommand {
  final String name;
  final String description;
  final int cooldown;
  final Future<void> Function(IMessage message, List<String> args, Bot bot) execute;

  PrefixCommand({
    required this.name,
    this.description = '',
    this.cooldown = 3,
    required this.execute,
  });
}

SlashCommandBuilder createSlashCommand(
  String name,
  String description, {
  List<CommandOptionBuilder> options = const [],
}) {
  return SlashCommandBuilder(name, description, options: options);
}
