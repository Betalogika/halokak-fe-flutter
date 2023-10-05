class LoginResponse {
  String? token;
  String? email;
  String? name;
  String? uid;
  String? message;

  LoginResponse({ this.token, this.email, this.name, this.uid });

  factory LoginResponse.from(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      email: json['email'],
      name: json['name'],
      uid: json['uid'],
    );
  }
}