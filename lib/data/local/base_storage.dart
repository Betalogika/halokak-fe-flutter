import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:halokak_app/configs/environment.dart';

class BaseStorage {
  final storage = const FlutterSecureStorage();
  final iosOptions = const IOSOptions();
  final androidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  //don't use readAll and deleteAll method cuz windows not support it yet
  //don't use containsKey method cuz not reliable on ios/macOS instead use the read

  Future<void> create(String key, String value) async {
    return storage.write(key: key, value: value, iOptions: iosOptions, aOptions: androidOptions);
  }
  Future<String?> read(String key) async {
    return storage.read(key: key, iOptions: iosOptions, aOptions: androidOptions);
  }
  Future<void> delete(String key) async {
    return storage.delete(key: key, iOptions: iosOptions, aOptions: androidOptions);
  }

  static final String _base = Environment().config?.baseLsUrl ?? "";

  var tokenKey = "${_base}token";
  var hiveKey = "${_base}hive";
  var currentUserIdKey = "${_base}current_user_id";
}