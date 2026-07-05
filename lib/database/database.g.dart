// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

class User extends DataClass implements Insertable<User> {
  final String id;
  final String username;
  final String? discriminator;
  final String? avatar;
  final bool isBot;
  final int createdAt;
  final int updatedAt;

  const User({
    required this.id,
    required this.username,
    this.discriminator,
    this.avatar,
    required this.isBot,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'username': Variable<String>(username),
      'discriminator': Variable<String?>(discriminator),
      'avatar': Variable<String?>(avatar),
      'is_bot': Variable<bool>(isBot),
      'created_at': Variable<int>(createdAt),
      'updated_at': Variable<int>(updatedAt),
    };
  }

  factory User.fromMap(Map<String, dynamic> map, {String? prefix}) {
    return User(
      id: map['${prefix}id'] as String,
      username: map['${prefix}username'] as String,
      discriminator: map['${prefix}discriminator'] as String?,
      avatar: map['${prefix}avatar'] as String?,
      isBot: map['${prefix}is_bot'] as bool,
      createdAt: map['${prefix}created_at'] as int,
      updatedAt: map['${prefix}updated_at'] as int,
    );
  }
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> username;
  final Value<String?> discriminator;
  final Value<String?> avatar;
  final Value<bool> isBot;
  final Value<int> createdAt;
  final Value<int> updatedAt;

  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.discriminator = const Value.absent(),
    this.avatar = const Value.absent(),
    this.isBot = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $UsersTable(this.attachedDatabase, [this._alias]);

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );

  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );

  late final GeneratedColumn<String?> discriminator = GeneratedColumn<String>(
    'discriminator',
    aliasedName,
    true,
    type: DriftSqlType.string,
  );

  late final GeneratedColumn<String?> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
  );

  late final GeneratedColumn<bool> isBot = GeneratedColumn<bool>(
    'is_bot',
    aliasedName,
    false,
    type: DriftSqlType.bool,
  );

  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );

  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );

  @override
  Set<GeneratedColumn> get primaryKey => {id};

  @override
  $UsersTable createAlias(String alias) => $UsersTable(attachedDatabase, alias);

  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromMap(data, prefix: tablePrefix ?? aliasedName);
  }

  @override
  String get aliasedName => _alias ?? 'users';

  @override
  String get actualTableName => 'users';
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);

  late final $UsersTable users = $UsersTable(this);

  @override
  Iterable<TableInfo> get allTables => [users];

  @override
  Migrator createMigrator() => SqliteMigrator(this);
}
