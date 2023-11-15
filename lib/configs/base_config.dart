abstract class BaseConfig {
  String get baseDbUrl;
  String get baseLsUrl;
  String get baseApiUrl;
  String get baseExternalUrl;
  String get host;
  bool get useHttps;
  bool get trackEvents;
  bool get reportErrors;
  String get clientKey;
}