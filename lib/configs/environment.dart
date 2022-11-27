import 'package:halokak_app/configs/prod_config.dart';
import 'package:halokak_app/configs/staging_config.dart';

import 'base_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  BaseConfig? config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      default:
        return StagingConfig();
    }
  }
}