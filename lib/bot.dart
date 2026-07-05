import 'package:nyxx/nyxx.dart';
import 'config.dart';
import 'database/database.dart';
import 'models/user.dart';
import 'handlers/commands.dart';
import 'handlers/events.dart';
import 'handlers/prefix.dart';
import 'handlers/logger.dart';

class Bot {
  late final INyxx client;
  late final Config config;
  late final Database database;
  late final UserModel userModel;
  late final CommandHandler commandHandler;
  late final EventHandler eventHandler;
  late final PrefixHandler prefixHandler;

  Bot() {
    config = Config();
    config.load();
  }

  Future<void> init() async {
    Logger.info('Initializing database...');
    database = Database();
    userModel = UserModel(database);

    Logger.info('Connecting to Discord...');
    client = await Nyxx.connectGateway(
      config.token,
      GatewayIntents.allUnprivileged |
          GatewayIntents.messageContent |
          GatewayIntents.guilds |
          GatewayIntents.guildMessages |
          GatewayIntents.directMessages,
    );

    commandHandler = CommandHandler();
    eventHandler = EventHandler();
    prefixHandler = PrefixHandler(this);

    await _registerCommands();
    await _registerEvents();
    await _setupListeners();

    Logger.info('Bot initialized successfully!');
  }

  Future<void> _registerCommands() async {
    commandHandler.registerSlash('ping', pingCommand);
    commandHandler.registerPrefix('ping', pingCommand);
    await commandHandler.loadCommands(this);
    await commandHandler.syncCommands(client);
  }

  Future<void> _registerEvents() async {
    eventHandler.register('ready', onReady);
    await eventHandler.loadEvents(this);
  }

  Future<void> _setupListeners() async {
    client.onReady.listen((event) {
      eventHandler.call('ready', client, this);
    });

    client.onMessageCreate.listen((event) {
      onMessageCreate(event.message, this);
    });

    client.onInteractionCreate.listen((event) {
      onInteractionCreate(event.interaction, this);
    });

    client.onGuildCreate.listen((event) {
      onGuildCreate(event.guild, this);
    });

    client.onGuildDelete.listen((event) {
      onGuildDelete(event.guild, this);
    });
  }
}

// Forward declarations for commands/events that reference Bot
import 'events/ready.dart';
import 'events/message_create.dart';
import 'events/interaction_create.dart';
import 'events/guild_create.dart';
import 'events/guild_delete.dart';
import 'commands/slash/public/ping.dart';
import 'commands/prefix/public/ping.dart';
