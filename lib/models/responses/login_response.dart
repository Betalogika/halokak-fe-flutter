import '../db/account_model.dart';

class LoginResponse {
  String? message;
  Account? data;

  LoginResponse({ this.message, this.data });

  factory LoginResponse.from(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      data: json['data'] != null ? Account.from(json['data']) : null,
    );
  }
}