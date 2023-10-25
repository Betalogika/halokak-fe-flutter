import 'package:flutter/cupertino.dart';
import 'package:halokak_app/data/database/account_db.dart';
import 'package:halokak_app/data/local/user_storage.dart';
import 'package:halokak_app/models/db/account_model.dart';
import 'package:halokak_app/models/responses/login_response.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../configs/environment.dart';

class AuthProvider extends ChangeNotifier {
  UserStorage userStorage = UserStorage();
  AccountDB userDB = AccountDB();
  String token = "";
  Account? user;
  PackageInfo? packageInfo;

  bool get isAuthenticated => token.isNotEmpty;
  String get appVersionName {
    if (const String.fromEnvironment('ENVIRONMENT',
        defaultValue: Environment.STAGING) != Environment.PROD) {
      return "v${packageInfo?.version ?? "-"}_${packageInfo?.buildNumber ?? "-"}";
    }
    return "v${packageInfo?.version ?? "-"}";
  }

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
    token = data.data?.token ?? "";
    userStorage.addToken(token);
    userStorage.addCurrentUserId(data.data?.id.toString() ?? "");
    user = data.data;
    if (data.data != null) {
      userDB.saveUser(data.data!);
    }
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