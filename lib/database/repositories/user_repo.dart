import 'dart:developer';
import 'package:shopping_list_with_sqflite_db_december/database/database.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/contract/user_repo_contract.dart';
import 'package:shopping_list_with_sqflite_db_december/exception/login_exception.dart';
import 'package:shopping_list_with_sqflite_db_december/models/user_model.dart';

class UserRepo implements UserRepoContract {
  final DatabaseHelper dbHelper = DatabaseHelper.init();

  @override
  Future<int> createUser(Users user) async {
    final db = dbHelper.database;
    log('${user.toMap()}');
    try {
      final res = await db.insert('users', user.toMap());
      return res;
    } on Exception catch (e) {
      throw LoginException();
    }
  }

  @override
  Future<int?> getUserId(Users user) async {
    final db = dbHelper.database;
    List<Map<String, Object?>> result = await db.query('users',
        where: 'userName =? AND userPassword =?',
        whereArgs: [user.userName, user.userPassword]);
    return result.first["userId"] as int?;
  }
}
