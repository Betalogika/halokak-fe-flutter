import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halokak_app/data/local/user_storage.dart';
import 'package:halokak_app/data/remote/base_api.dart';
import 'package:halokak_app/models/responses/login_response.dart';
import 'package:http/http.dart' as http;


class AuthAPI extends BaseAPI {

  Future<http.Response> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});
    http.Response response = await http.post(Uri.parse(super.loginPath), headers: getHeader(""), body: body);
    return response;
  }

  Future<LoginResponse> loginFirebase(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      final token = await credential.user?.getIdToken();
      return LoginResponse(token: token, email: credential.user?.email, name: credential.user?.displayName, uid: credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      var response = LoginResponse(token: null, email: null, name: null, uid: null);
      response.message = e.message ?? "Kesalahan Sistem";
      if (e.code == 'user-not-found') {
        response.message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        response.message = 'Wrong password provided for that user.';
      }
      return response;
    }
  }

  Future<LoginResponse> registerFirebase(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      final token = await credential.user?.getIdToken();
      return LoginResponse(token: token, email: credential.user?.email, name: credential.user?.displayName, uid: credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      var response = LoginResponse(token: null, email: null, name: null, uid: null);
      response.message = e.message ?? "Kesalahan Sistem";
      if (e.code == 'weak-password') {
        response.message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        response.message = 'The account already exists for that email.';
      }
      return response;
    }
  }

  Future<http.Response> logout(int id, String token) async {
    var token = await UserStorage().getToken();
    http.Response response = await http.get(Uri.parse(super.logoutPath), headers: getHeader(token ?? ""));
    return response;
  }

}