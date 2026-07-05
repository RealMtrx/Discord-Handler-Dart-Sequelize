import '../database/database.dart';

class UserModel {
  final Database _db;

  UserModel(this._db);

  Future<User?> findById(String id) async {
    try {
      return await _db.getUserById(id);
    } catch (_) {
      return null;
    }
  }

  Future<void> save(User user) async {
    await _db.upsertUser(UsersCompanion(
      id: Value(user.id),
      username: Value(user.username),
      discriminator: Value(user.discriminator),
      avatar: Value(user.avatar),
      isBot: Value(user.isBot),
      createdAt: Value(user.createdAt),
      updatedAt: Value(user.updatedAt),
    ));
  }

  Future<List<User>> findAll() async {
    return _db.getAllUsers();
  }

  Future<void> remove(String id) async {
    await _db.deleteUser(id);
  }
}
