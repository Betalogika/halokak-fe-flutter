import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:halokak_app/data/database/account_db.dart';
import 'package:halokak_app/data/local/user_storage.dart';
import 'package:halokak_app/models/responses/login_response.dart';
import 'package:halokak_app/models/account_model.dart';

class AuthProvider extends ChangeNotifier {
  UserStorage userStorage = UserStorage();
  AccountDB userDB = AccountDB();
  String token = "";
  Account? user;

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

  void login(String emailAddress, String password) async {
  }

  void setAuthenticated(LoginResponse data) {
    token = data.token ?? "";
    userStorage.addToken(token);
    userStorage.addCurrentUserId(data.uid ?? "");
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