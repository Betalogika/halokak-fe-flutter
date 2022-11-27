import 'package:flutter/cupertino.dart';
import 'package:halokak_app/data/database/user_db.dart';
import 'package:halokak_app/data/local/user_storage.dart';
import 'package:halokak_app/models/responses/login_response.dart';
import 'package:halokak_app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserStorage userStorage = UserStorage();
  UserDB userDB = UserDB();
  String token = "";
  User? user;

  bool get isAuthenticated => token.isNotEmpty;

  AuthProvider() {
    initUser();
  }

  void initUser() async {
    await userDB.open();
    token = await userStorage.getToken() ?? "";
    String userId = await userStorage.getCurrentUserId() ?? "";
    user = userDB.getUser(userId);
    notifyListeners();
  }

  void closeDB() {
    userDB.close();
  }

  void setAuthenticated(LoginResponse data) {
    token = data.token ?? "";
    userStorage.addToken(token);
    userStorage.addCurrentUserId(data.user?.id ?? "");
    notifyListeners();
  }

  void setUnauthenticated() {
    user = null;
    token = "";
    userStorage.removeToken();
    userStorage.removeCurrentUserId();
    notifyListeners();
  }
}