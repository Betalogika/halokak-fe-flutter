import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halokak_app/custom/exit_popup.dart';
import 'package:halokak_app/data/local/text_storage.dart';
import 'package:halokak_app/data/remote/auth_api.dart';
import 'package:halokak_app/models/error_model.dart';
import 'package:halokak_app/models/responses/login_response.dart';
import 'package:halokak_app/providers/auth_provider.dart';
import 'package:halokak_app/custom/progress_dialog.dart';
import 'package:halokak_app/custom/toast.dart';
import 'package:provider/provider.dart';

class LoginScene extends StatefulWidget {
  const LoginScene({super.key});

  @override
  State<LoginScene> createState() =>_LoginScene();
}

class _LoginScene extends State<LoginScene> {
  final AuthAPI _authApi = AuthAPI();
  String email = "";
  String password = "";
  AuthProvider? authProvider;

  @override
  void initState() {
    super.initState();
    setupExitCloseWindow(context);
    authProvider = Provider.of(context, listen: false);
  }

  void _onLoginClicked(BuildContext context) async {
    FToast fToast = FToast().init(context);
    DialogBuilder(context).showLoadingIndicator("");
    try {
      var req = await _authApi.login(email, password);
      if (req.statusCode == 200) {
        authProvider?.setAuthenticated(LoginResponse.from(jsonDecode(req.body)));
      } else {
        if (!mounted) return;
        showToast(context, fToast, ErrorModel.from(jsonDecode(req.body)).message);
      }
    } on Exception catch (e) {
      showToast(context, fToast, e.toString());
    }
    if (!mounted) return;
    DialogBuilder(context).hideOpenDialog();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                  child: const Text(TextStorage.titleAuth),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: TextStorage.lblEmail,
                    ),
                    onChanged: (val) => setState(() { email = val; }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: TextStorage.lblPassword,
                    ),
                    onChanged: (val) => setState(() { password = val; }),
                  ),
                ),
                Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(TextStorage.lblLogin),
                      onPressed: () {
                        _onLoginClicked(context);
                      },
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}