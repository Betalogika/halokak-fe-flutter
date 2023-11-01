import 'package:halokak_app/configs/key_config.dart';
import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get baseDbUrl => "prod_box_";

  @override
  String get baseLsUrl => "prod_ls_";

  @override
  String get baseApiUrl => "https://api-halokak.betalogika.tech/api/v1";

  @override
  String get baseExternalUrl => "https://user-bahteramas-halokak.betalogika.tech";

  @override
  bool get reportErrors => true;

  @override
  bool get trackEvents => true;

  @override
  bool get useHttps => true;

  @override
  String get clientKey => prodClientKey;
}