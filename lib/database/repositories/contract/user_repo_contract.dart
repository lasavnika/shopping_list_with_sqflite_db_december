import 'package:shopping_list_with_sqflite_db_december/models/user_model.dart';

abstract class UserRepoContract {
  Future<int> createUser(Users user);
  Future<int?> getUserId(Users user);
}
