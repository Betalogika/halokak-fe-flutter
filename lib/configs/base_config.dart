abstract class BaseConfig {
  String get baseDbUrl;
  String get baseLsUrl;
  String get baseApiUrl;
  String get baseExternalUrl;
  bool get useHttps;
  bool get trackEvents;
  bool get reportErrors;
  String get clientKey;
}