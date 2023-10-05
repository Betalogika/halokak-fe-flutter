import 'package:hive/hive.dart';
import 'package:halokak_app/data/database/base_db.dart';
import 'package:halokak_app/models/db/account_model.dart';

class AccountDB extends BaseDB {
  Box<Account>? box;

  Future<void> open() async {
    box = await openBox<Account>(userBox);
  }

  Future<void> close() async {
    box?.compact();
    box?.close();
  }

  void saveUser(Account data) async {
    box?.put(data.id, data);
  }

  Account? getUser(String key) {
    return box?.get(key);
  }
}