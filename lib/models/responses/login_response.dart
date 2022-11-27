import 'package:halokak_app/models/user_model.dart';

class LoginResponse {
  String? token;
  User? user;

  LoginResponse({ this.token, this.user });

  factory LoginResponse.from(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? "",
      user: json['user'] != null ? User.from(json['qlinik']) : null,
    );
  }
}