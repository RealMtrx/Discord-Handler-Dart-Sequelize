# Discord Handler Dart Sequelize

A Discord bot built with **Dart**, **nyxx** (Discord library), and **drift** (SQLite ORM).

## Features

- Slash command & prefix command support
- Event handling (ready, message, interaction, guild create/delete)
- SQLite database via drift ORM
- Cooldown system
- Webhook error logging
- Anti-crash handler
- Logger system

## Setup

1. Clone the repository
2. Copy `.env.example` to `.env` and fill in your values
3. Run `dart pub get`
4. Run `dart run build_runner build` to generate drift files
5. Run `dart run lib/main.dart`

## Commands

- `/ping` - Slash ping command
- `!ping` - Prefix ping command
