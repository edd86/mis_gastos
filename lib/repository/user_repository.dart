import 'package:mis_gastos/data/database_helper.dart';
import 'package:mis_gastos/model/user.dart';

class UserRepository {
  Future<User?> addUser(User user) async {
    try {
      final db = await DatabaseHelper().database;
      int id = await db.insert('users', user.toJson());
      return user.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  Future<User?> findUserByEmail(String email, String password) async {
    try {
      final db = await DatabaseHelper().database;
      final user =
          await db.query('users', where: 'email = ?', whereArgs: [email]);
      if (user.isNotEmpty) {
        final userFound = User.fromJson(user.first);
        if (password == userFound.password) {
          return userFound;
        }
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
