import 'dart:io';
import 'package:nyxx/nyxx.dart';
import '../bot.dart';
import '../core/command_utils.dart';
import 'logger.dart';

class CommandHandler {
  final Map<String, SlashCommandBuilder> _slashCommands = {};
  final Map<String, PrefixCommand> _prefixCommands = {};

  void registerSlash(String name, SlashCommandBuilder builder) {
    _slashCommands[name] = builder;
  }

  void registerPrefix(String name, PrefixCommand command) {
    _prefixCommands[name] = command;
  }

  SlashCommandBuilder? getSlash(String name) => _slashCommands[name];
  PrefixCommand? getPrefix(String name) => _prefixCommands[name];

  Map<String, SlashCommandBuilder> get slashCommands => _slashCommands;
  Map<String, PrefixCommand> get prefixCommands => _prefixCommands;

  Future<void> loadCommands(Bot bot) async {
    final dir = Directory('lib/commands/slash/public');
    if (await dir.exists()) {
      final files = dir.listSync().whereType<File>().toList();
      for (final file in files) {
        final name = file.uri.pathSegments.last.replaceAll('.dart', '');
        Logger.info('Loaded slash command: $name');
      }
    }

    final prefixDir = Directory('lib/commands/prefix/public');
    if (await prefixDir.exists()) {
      final files = prefixDir.listSync().whereType<File>().toList();
      for (final file in files) {
        final name = file.uri.pathSegments.last.replaceAll('.dart', '');
        Logger.info('Loaded prefix command: $name');
      }
    }
  }

  Future<void> syncCommands(INyxx client) async {
    final builder = GlobalCommandsBuilder();
    for (final cmd in _slashCommands.values) {
      builder.commands.add(cmd);
    }
    await client.syncGlobalCommands(builder);
    Logger.info('Synced ${_slashCommands.length} slash commands');
  }
}
