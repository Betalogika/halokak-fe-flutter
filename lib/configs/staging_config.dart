import 'package:halokak_app/configs/key_config.dart';
import 'base_config.dart';

class StagingConfig implements BaseConfig {
  @override
  String get baseDbUrl => "staging_box_";

  @override
  String get baseLsUrl => "staging_ls_";

  @override
  String get baseApiUrl => "https://url_staging";

  @override
  bool get reportErrors => true;

  @override
  bool get trackEvents => true;

  @override
  bool get useHttps => true;

  @override
  String get clientKey => stagingClientKey;
}