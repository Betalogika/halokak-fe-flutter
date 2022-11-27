import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:halokak_app/models/user_model.dart';
import '../../configs/environment.dart';
import '../local/user_storage.dart';

class BaseDB {
  final userStorage = UserStorage();

  Future<void> setupDB() async {
    var isHiveKeyGenerated = await userStorage.isHiveKeyGenerated();
    if (!isHiveKeyGenerated) {
      userStorage.addHiveKey(base64UrlEncode(Hive.generateSecureKey()));
    }
    Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
  }

  Future<Box<T>> openBox<T>(String boxKey) async {
    final key = await userStorage.getHiveKey();
    final encryptionKey = base64Url.decode(key ?? "");
    final encryptedBox= await Hive.openBox<T>(boxKey, encryptionCipher: HiveAesCipher(encryptionKey));
    return encryptedBox;
  }

  Future<LazyBox<T>> openLazyBox<T>(String boxKey) async {
    final key = await userStorage.getHiveKey();
    final encryptionKey = base64Url.decode(key ?? "");
    final encryptedBox= await Hive.openLazyBox<T>(boxKey, encryptionCipher: HiveAesCipher(encryptionKey));
    return encryptedBox;
  }

  static final String _base = Environment().config?.baseDbUrl ?? "";

  var userBox = "${_base}user";
}