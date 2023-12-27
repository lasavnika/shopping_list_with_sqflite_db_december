// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shopping_list_with_sqflite_db_december/exception/base_exception.dart';

class LoginException implements BaseException {
  final String? message;
  LoginException({
    this.message,
  });
}
