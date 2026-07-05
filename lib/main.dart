import 'package:dotenv/dotenv.dart';
import 'bot.dart';
import 'handlers/anticrash.dart';
import 'handlers/logger.dart';

Future<void> main() async {
  try {
    await DotEnv().load('.env');
  } catch (_) {
    Logger.warn('No .env file found, using system environment variables');
  }

  AntiCrash.setup();

  Logger.info('Starting Discord Handler Dart Sequelize...');

  final bot = Bot();
  await bot.init();

  Logger.info('Bot is ready!');
}
