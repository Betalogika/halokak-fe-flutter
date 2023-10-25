import 'dart:convert';

import 'package:halokak_app/data/local/user_storage.dart';
import 'package:halokak_app/data/remote/base_api.dart';
import 'package:halokak_app/models/responses/login_response.dart';


class AuthAPI extends BaseAPI {

  Future<LoginResponse> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});
    var response = await requestResponse(RM.post, Uri.parse(super.loginPath), headers: getHeader(), body: body);
    return LoginResponse.from(response);
  }

  Future<LoginResponse> register(String name, String email, String password, String passwordConfirm) async {
    var body = jsonEncode({'username': name,'email': email, 'password': password, 'password_confirmation': passwordConfirm});
    var response = await requestResponse(RM.post, Uri.parse(super.registerPath), headers: getHeader(), body: body);
    return LoginResponse.from(response);
  }

  Future<dynamic> logout(int id, String token) async {
    var token = await UserStorage().getToken();
    var response = await requestResponse(RM.get, Uri.parse(super.logoutPath), headers: getHeader(token: token ?? ''));
    return response;
  }
}