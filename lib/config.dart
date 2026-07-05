import 'dart:io';

class Config {
  static final Config _instance = Config._internal();
  factory Config() => _instance;
  Config._internal();

  late final String token;
  late final String clientId;
  late final String ownerId;
  late final String dbDialect;
  late final String dbStorage;
  late final String? webhookUrl;
  late final String? webhookId;
  late final String? webhookToken;
  late final String prefix;

  void load() {
    token = _getEnv('TOKEN');
    clientId = _getEnv('CLIENT_ID');
    ownerId = _getEnv('OWNER_ID');
    dbDialect = _getEnv('DB_DIALECT', defaultValue: 'sqlite');
    dbStorage = _getEnv('DB_STORAGE', defaultValue: 'database.sqlite');
    webhookUrl = Platform.environment['WEBHOOK_URL'];
    webhookId = Platform.environment['WEBHOOK_ID'];
    webhookToken = Platform.environment['WEBHOOK_TOKEN'];
    prefix = _getEnv('PREFIX', defaultValue: '!');
  }

  String _getEnv(String key, {String? defaultValue}) {
    final value = Platform.environment[key];
    if (value == null || value.isEmpty) {
      if (defaultValue != null) return defaultValue;
      throw Exception('Missing required environment variable: $key');
    }
    return value;
  }
}
