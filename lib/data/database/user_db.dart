import 'package:hive/hive.dart';
import 'package:halokak_app/data/database/base_db.dart';
import 'package:halokak_app/models/user_model.dart';

class UserDB extends BaseDB {
  Box<User>? box;

  Future<void> open() async {
    box = await openBox<User>(userBox);
  }

  Future<void> close() async {
    box?.compact();
    box?.close();
  }

  void saveUser(User data) async {
    box?.put(data.id, data);
  }

  User? getUser(String key) {
    return box?.get(key);
  }
}