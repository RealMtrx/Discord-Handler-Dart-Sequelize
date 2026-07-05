import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import '../config.dart';

part 'database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get discriminator => text().nullable()();
  TextColumn get avatar => text().nullable()();
  BoolColumn get isBot => boolean()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Users])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<User> getUserById(String id) async {
    return (select(users)..where((u) => u.id.equals(id))).getSingle();
  }

  Future<void> upsertUser(UsersCompanion entry) async {
    await into(users).insertOnConflictUpdate(entry);
  }

  Future<List<User>> getAllUsers() async {
    return select(users).get();
  }

  Future<int> deleteUser(String id) async {
    return (delete(users)..where((u) => u.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final config = Config();
    final dbPath = config.dbStorage;
    final file = File(dbPath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    return NativeDatabase(file);
  });
}
