import 'dart:convert';

import 'package:halokak_app/data/local/user_storage.dart';
import 'package:halokak_app/data/remote/base_api.dart';
import 'package:http/http.dart' as http;

class AuthAPI extends BaseAPI {

  Future<http.Response> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});
    http.Response response = await http.post(Uri.parse(super.loginPath), headers: getHeader(""), body: body);
    return response;
  }

  Future<http.Response> logout(int id, String token) async {
    var token = await UserStorage().getToken();
    http.Response response = await http.get(Uri.parse(super.logoutPath), headers: getHeader(token ?? ""));
    return response;
  }

}