import 'package:halokak_app/data/local/base_storage.dart';

class UserStorage extends BaseStorage {

  Future<void> addToken(String data) async {
    await create(tokenKey, data);
  }

  Future<String?> getToken() async {
    return read(tokenKey);
  }

  Future<void> removeToken() async {
    await delete(tokenKey);
  }

  Future<void> addHiveKey(String data) async {
    await create(hiveKey, data);
  }

  Future<String?> getHiveKey() async {
    return read(hiveKey);
  }

  Future<bool> isHiveKeyGenerated() async {
    var key = await getHiveKey();
    return key != null || (key?.isNotEmpty ?? false);
  }

  Future<void> addCurrentUserId(String data) async {
    await create(currentUserIdKey, data);
  }

  Future<String?> getCurrentUserId() async {
    return read(currentUserIdKey);
  }

  Future<void> removeCurrentUserId() async {
    await delete(currentUserIdKey);
  }

}