<div align="center">
  <h1>Discord Handler — Dart (SQL Edition)</h1>
  <p><strong>A production-ready Discord bot framework built with Nyxx and drift — supports SQLite, PostgreSQL, and MySQL with a modular lib/ architecture.</strong></p>

  <p>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize/releases"><img src="https://img.shields.io/badge/version-0.9.0--beta-yellow" alt="Version 0.9.0 Beta"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize/stargazers"><img src="https://img.shields.io/github/stars/RealMtrx/Discord-Handler-Dart-Sequelize" alt="Stars"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize/issues"><img src="https://img.shields.io/github/issues/RealMtrx/Discord-Handler-Dart-Sequelize" alt="Issues"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize/network"><img src="https://img.shields.io/github/forks/RealMtrx/Discord-Handler-Dart-Sequelize" alt="Forks"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler/graphs/contributors"><img src="https://img.shields.io/badge/ecosystem-26%20repos-brightgreen" alt="26 Repos"></a>
    <a href="https://discord.gg/0hu2"><img src="https://img.shields.io/badge/discord-0hu2-5865F2" alt="Discord"></a>
  </p>

  <br>

  <p>
    <a href="#-features">Features</a> •
    <a href="#-quick-start">Quick Start</a> •
    <a href="#-project-structure">Structure</a> •
    <a href="#-database-configuration">Database Config</a> •
    <a href="#-api-reference">API</a> •
    <a href="#-mongodb-edition">MongoDB Edition</a> •
    <a href="#-related-repositories">Ecosystem</a>
  </p>
</div>

---

## Overview

An SQL edition of the Discord Handler framework built with **Dart**, **Nyxx** (Discord library), and **drift** (SQLite / PostgreSQL / MySQL ORM). It mirrors the architecture of the MongoDB edition, replacing document storage with relational database support while keeping the same modular structure, anti-crash protection, webhook logging, and dual command system.

## Features

- **Dual Command System** — Slash commands and prefix commands
- **Event-Driven Architecture** — Stream-based reactive design via Nyxx
- **drift ORM** — Type-safe SQL queries; supports SQLite, PostgreSQL, MySQL
- **Anti-Crash Handler** — Global error catching that keeps your bot online
- **Webhook Error Logging** — Real-time error and guild event reporting
- **Cooldown System** — Per-command rate limiting
- **Emoji Constants** — Centralized unicode emoji definitions
- **Environment Configuration** — Secure token management via `.env`
- **Code Generation** — drift `build_runner` for type-safe DAOs

## Quick Start

```bash
# Clone
git clone https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize.git
cd Discord-Handler-Dart-Sequelize

# Configure
cp .env.example .env
# Edit .env with your bot token, client ID, and database details

# Install dependencies
dart pub get

# Generate drift code
dart run build_runner build

# Run the bot
dart run lib/main.dart
```

## Project Structure

```
lib/
├── main.dart                       # Entry point
├── bot.dart                        # Bot client initialization
├── config.dart                     # .env configuration loader
├── database/
│   ├── database.dart               # Drift database definition
│   └── database.g.dart             # Generated drift code
├── models/
│   └── user.dart                   # User model / table definition
├── handlers/
│   ├── anticrash.dart              # Global error handler
│   ├── commands.dart               # Slash command loader
│   ├── events.dart                 # Event loader
│   ├── logger.dart                 # Logging utility
│   └── prefix.dart                 # Prefix command handler
├── events/
│   ├── ready.dart                  # Bot ready event
│   ├── message_create.dart         # Message create listener
│   ├── interaction_create.dart     # Interaction create listener
│   ├── guild_create.dart           # Guild create listener
│   └── guild_delete.dart           # Guild delete listener
├── core/
│   ├── webhooks.dart               # Webhook sender
│   ├── emojis.dart                 # Emoji constants
│   ├── command_utils.dart          # Command helpers
│   └── cooldown.dart               # Cooldown manager
└── commands/
    ├── slash/public/ping.dart      # Example slash command
    └── prefix/public/ping.dart     # Example prefix command
```

## Database Configuration

Configure your database in `.env`:

```env
# Bot
TOKEN=your_discord_bot_token
CLIENT_ID=your_client_id
OWNER_ID=your_user_id
PREFIX=!

# Database
DB_DIALECT=sqlite         # sqlite | postgresql | mysql
DB_STORAGE=database.sqlite  # SQLite file path (sqlite only)

# Webhooks
WEBHOOK_URL=
WEBHOOK_ID=
WEBHOOK_TOKEN=
```

### Dialect examples

**SQLite (default)** — zero configuration, file-based:
```env
DB_DIALECT=sqlite
DB_STORAGE=database.sqlite
```

**PostgreSQL**:
```env
DB_DIALECT=postgresql
DB_HOST=localhost
DB_PORT=5432
DB_NAME=discord_bot
DB_USER=postgres
DB_PASSWORD=your_password
```

**MySQL**:
```env
DB_DIALECT=mysql
DB_HOST=localhost
DB_PORT=3306
DB_NAME=discord_bot
DB_USER=root
DB_PASSWORD=your_password
```

## API Reference

### Drift Database Setup (`lib/database/database.dart`)

```dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3/open.dart';

part 'database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get discriminator => text().nullable()();
  TextColumn get avatar => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = File('database.sqlite');
    return NativeDatabase(file);
  });
}
```

### Slash Command Example (`lib/commands/slash/public/ping.dart`)

```dart
import 'package:nyxx/nyxx.dart';

class SlashPing {
  static const name = 'ping';
  static const description = 'Replies with Pong!';

  static Future<void> execute(ISlashCommandInteraction interaction) async {
    await interaction.respond(MessageBuilder(content: 'Pong!'));
  }
}
```

### Prefix Command Example (`lib/commands/prefix/public/ping.dart`)

```dart
import 'package:nyxx/nyxx.dart';

class PrefixPing {
  static const name = 'ping';

  static Future<void> execute(IMessage message) async {
    await message.channel.sendMessage(MessageBuilder(content: 'Pong!'));
  }
}
```

## Adding Commands

1. Create a file in `lib/commands/slash/public/<name>.dart` or `lib/commands/prefix/public/<name>.dart`
2. Define a class with `name`, `description` (slash only), and a static `execute` method
3. The command loader automatically picks up new files

## MongoDB Edition

Prefer a document database? Use the **MongoDB edition** of this handler:

<div align="center">
  <a href="https://github.com/RealMtrx/Discord-Handler-Dart"><img src="https://img.shields.io/badge/Discord--Handler--Dart-MongoDB%20Edition-blue?style=for-the-badge" alt="MongoDB Edition"></a>
</div>

The MongoDB edition uses `mongo_dart` instead of drift, but shares the same command, event, and handler structure. You can switch between editions without relearning the architecture.

## Related Repositories

The Discord Handler ecosystem includes **26 repositories** — 13 Core Framework (MongoDB) editions and 13 Database (SQL) editions, covering 13 programming languages.

### Core Framework (MongoDB) Editions

| # | Language | Repository |
|---|----------|------------|
| 1 | JavaScript | [Discord-Handler-Js](https://github.com/RealMtrx/Discord-Handler-Js) |
| 2 | TypeScript | [Discord-Handler-Ts](https://github.com/RealMtrx/Discord-Handler-Ts) |
| 3 | Go | [Discord-Handler-Go](https://github.com/RealMtrx/Discord-Handler-Go) |
| 4 | Rust | [Discord-Handler-Rs](https://github.com/RealMtrx/Discord-Handler-Rs) |
| 5 | Python | [Discord-Handler-Py](https://github.com/RealMtrx/Discord-Handler-Py) |
| 6 | C# | [Discord-Handler-Cs](https://github.com/RealMtrx/Discord-Handler-Cs) |
| 7 | Java | [Discord-Handler-Java](https://github.com/RealMtrx/Discord-Handler-Java) |
| 8 | Kotlin | [Discord-Handler-Kt](https://github.com/RealMtrx/Discord-Handler-Kt) |
| 9 | C++ | [Discord-Handler-Cpp](https://github.com/RealMtrx/Discord-Handler-Cpp) |
| 10 | Dart | [Discord-Handler-Dart](https://github.com/RealMtrx/Discord-Handler-Dart) |
| 11 | Ruby | [Discord-Handler-Rb](https://github.com/RealMtrx/Discord-Handler-Rb) |
| 12 | Lua | [Discord-Handler-Lua](https://github.com/RealMtrx/Discord-Handler-Lua) |
| 13 | PHP | [Discord-Handler-Php](https://github.com/RealMtrx/Discord-Handler-Php) |

### Database (SQL) Editions

| # | Language | Repository | ORM |
|---|----------|------------|-----|
| 1 | JavaScript | [Discord-Handler-Js-Sequelize](https://github.com/RealMtrx/Discord-Handler-Js-Sequelize) | Sequelize |
| 2 | TypeScript | [Discord-Handler-Ts-Sequelize](https://github.com/RealMtrx/Discord-Handler-Ts-Sequelize) | Sequelize |
| 3 | Go | [Discord-Handler-Go-Sequelize](https://github.com/RealMtrx/Discord-Handler-Go-Sequelize) | GORM |
| 4 | Rust | [Discord-Handler-Rs-Sequelize](https://github.com/RealMtrx/Discord-Handler-Rs-Sequelize) | Diesel |
| 5 | Python | [Discord-Handler-Py-Sequelize](https://github.com/RealMtrx/Discord-Handler-Py-Sequelize) | SQLAlchemy |
| 6 | C# | [Discord-Handler-Cs-Sequelize](https://github.com/RealMtrx/Discord-Handler-Cs-Sequelize) | EF Core |
| 7 | Java | [Discord-Handler-Java-Sequelize](https://github.com/RealMtrx/Discord-Handler-Java-Sequelize) | Hibernate |
| 8 | Kotlin | [Discord-Handler-Kt-Sequelize](https://github.com/RealMtrx/Discord-Handler-Kt-Sequelize) | Exposed |
| 9 | C++ | [Discord-Handler-Cpp-Sequelize](https://github.com/RealMtrx/Discord-Handler-Cpp-Sequelize) | sqlpp11 |
| 10 | **Dart** | **Discord-Handler-Dart-Sequelize** | **drift** |
| 11 | Ruby | [Discord-Handler-Rb-Sequelize](https://github.com/RealMtrx/Discord-Handler-Rb-Sequelize) | Sequel |
| 12 | Lua | [Discord-Handler-Lua-Sequelize](https://github.com/RealMtrx/Discord-Handler-Lua-Sequelize) | LuaSQL |
| 13 | PHP | [Discord-Handler-Php-Sequelize](https://github.com/RealMtrx/Discord-Handler-Php-Sequelize) | Eloquent |

### Hub Repository

<div align="center">
  <a href="https://github.com/RealMtrx/Discord-Handler"><img src="https://img.shields.io/badge/Hub-Discord--Handler-181717?style=for-the-badge&logo=github" alt="Hub Repository"></a>
</div>

The hub repo contains documentation, examples in every language, changelog, roadmap, and contribution guidelines.

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

Built by **Mtrx** — Discord: **0hu2**
