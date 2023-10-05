import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../configs/environment.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  void logData(String data) {
    if (const String.fromEnvironment('ENVIRONMENT',
        defaultValue: Environment.STAGING) != Environment.PROD) {
      log(data);
    }
  }
}