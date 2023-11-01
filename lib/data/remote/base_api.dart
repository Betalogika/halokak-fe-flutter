import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../configs/environment.dart';
import '../../models/error_model.dart';
import '../local/text_storage.dart';

enum RM {
  post,
  get,
  put,
  delete;
}

class BaseAPI {
  static String base = Environment().config?.baseApiUrl ?? "";
  static String baseExternal = Environment().config?.baseExternalUrl ?? "";

  static var authService = "$base/user/auth";
  var loginPath = "$authService/login";
  var registerPath = "$authService/register";
  var logoutPath = "$authService/logout";

  var forgotPasswordPagePath = "$baseExternal/forgot/password";

  Map<String,String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "API_KEY": Environment().config?.clientKey ?? ""
  };

  Map<String,String> getHeader({String token = ""}) {
    var result = headers;
    if (token.isNotEmpty) {
      result["Authorization"] = "Bearer $token";
    }
    result["X-HALOKAK-PLATFORM"] = "web";
    result["X-HALOKAK-VERSION"] = "1.0.0";
    return result;
  }

  Future<dynamic> requestResponse(RM method, Uri uri, {required Map<String, String> headers, Object? body}) async {
    logData(uri.toString());
    Future<http.Response> response;
    switch(method) {
      case RM.post:
        response = http.post(uri, headers: headers, body: body);
        break;
      case RM.put:
        response = http.put(uri, headers: headers);
        break;
      case RM.delete:
        response = http.delete(uri, headers: headers);
        break;
      default:
        response = http.get(uri, headers: headers);
        break;
    }
    try {
      final result = await response.timeout(const Duration(seconds: 180),
          onTimeout: () {
            // Time has run out, do what you wanted to do.
            throw ErrorException(TextStorage.errorRequestTimeout, code: ErrorExceptionCode.connectionTimeout.value);
          });
      return _returnResponse(result);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw ErrorException(TextStorage.errorConnectionTimeout, code: ErrorExceptionCode.socket.value);
      } else if (e is TimeoutException) {
        throw ErrorException(TextStorage.errorRequestTimeout, code: ErrorExceptionCode.requestTimeout.value);
      } else {
        rethrow;
      }
    }
  }

  dynamic _returnResponse(http.Response response) {
    var message = TextStorage.errorSystem;
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        logData(responseJson.toString());
        return responseJson;
      case 400:
        message = ErrorModel.from(json: jsonDecode(response.body), defaultMessage: TextStorage.errorBadRequest).message;
        break;
      case 401:
      case 403:
        message = ErrorModel.from(json: jsonDecode(response.body), defaultMessage: TextStorage.errorUnauthenticated).message;
        break;
      case 422:
        message = ErrorModel.from(json: jsonDecode(response.body), defaultMessage: TextStorage.errorUnProcessableEntity).message;
        break;
      case 500:
      default:
        message = 'Terjadi kesalahan Server dengan kode status : ${response.statusCode}';
        break;
    }
    throw ErrorException(message);
  }

  void logData(String data) {
    if (const String.fromEnvironment('ENVIRONMENT',
        defaultValue: Environment.STAGING) != Environment.PROD) {
      log(data);
    }
  }
}