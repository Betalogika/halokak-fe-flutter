import '../../configs/environment.dart';

class BaseAPI {
  static String base = Environment().config?.baseApiUrl ?? "";

  static var authService = "$base/auth";
  var loginPath = "$authService/login";
  var logoutPath = "$authService/logout";

  Map<String,String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "API_KEY": Environment().config?.clientKey ?? ""
  };

  Map<String,String> getHeader(String token) {
    var result = headers;
    if (token.isNotEmpty) {
      result["Authorization"] = "Bearer $token";
    }
    return result;
  }
}