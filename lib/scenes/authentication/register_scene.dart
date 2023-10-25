import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halokak_app/custom/exit_popup.dart';
import 'package:halokak_app/custom/progress_dialog.dart';
import 'package:halokak_app/custom/toast.dart';
import 'package:halokak_app/data/local/text_storage.dart';
import 'package:halokak_app/data/remote/auth_api.dart';
import 'package:halokak_app/models/enum/navigation_enum.dart';
import 'package:halokak_app/providers/auth_provider.dart';
import 'package:halokak_app/providers/navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../custom/custom_text_widget.dart';
import '../../custom/space.dart';
import '../../data/local/color_storage.dart';

class RegisterScene extends StatefulWidget {
  const RegisterScene({super.key});

  @override
  State<RegisterScene> createState() =>_RegisterScene();
}

class _RegisterScene extends State<RegisterScene> {
  final AuthAPI _authApi = AuthAPI();
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  AuthProvider? authProvider;
  NavigationProvider? _navigationProvider;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    setupExitCloseWindow(context);
    authProvider = Provider.of(context, listen: false);
    _navigationProvider = Provider.of(context, listen: false);
  }

  void _onRegisterClicked(BuildContext context) async {
    FToast fToast = FToast().init(context);
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty) {
      showToast(context, fToast, TextStorage.errorMandatoryData);
      return;
    }
    if (password != confirmPassword) {
      showToast(context, fToast, TextStorage.errorConfirmPassword);
      return;
    }
    DialogBuilder(context).showLoadingIndicator("");
    try {
      var req = await _authApi.register(name, email, password, confirmPassword);
      if (!mounted) return;
      showToast(context, fToast, req.message.toString());
      _navigationProvider?.setNavigationItem(NavigationItem.home);
    } on Exception catch (e) {
      showToast(context, fToast, e.toString());
    }
    if (!mounted) return;
    DialogBuilder(context).hideOpenDialog();
  }

  @override
  Widget build(BuildContext context) {
    String appVersionName = context.select<AuthProvider, String>((value) => value.appVersionName);
    return WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Scaffold(
          body: SingleChildScrollView(
            child:
            Container(
              color: Colors.white,
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child:
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: Sizes.p32, bottom: Sizes.p8, left: Sizes.p16, right: Sizes.p32),
                          child: IconButton(onPressed: () {
                            _navigationProvider?.backToPrevious();
                          }, icon: const Icon(Icons.close)),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: Sizes.p32, bottom: Sizes.p8, left: Sizes.p16, right: Sizes.p16),
                          child: Image.asset("assets/ill_icon.jpg"),
                        ),
                        Space.h24,
                        Container(
                          width: 408,
                          margin: const EdgeInsets.only(left: Sizes.p24, right: Sizes.p24),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: ColorStorage.disabled,
                                style: BorderStyle.solid,
                                width: Sizes.border,
                              ),
                              borderRadius: BorderRadius.circular(Sizes.p4)),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(Sizes.p24),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(value: TextStorage.titleRegister, fontWeight: FontWeight.bold, fontSize: 18, color: ColorStorage.blue),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: Sizes.p24, bottom: Sizes.p12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(value: TextStorage.titleUsername, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: Sizes.p24, right: Sizes.p24),
                                child:
                                SizedBox(
                                  height: 40,
                                  width: 360,
                                  child: TextField(
                                    style: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.black),
                                    decoration: InputDecoration(
                                        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.black),
                                        hintStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.gray),
                                        hintText: TextStorage.phUsername,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: ColorStorage.border),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: ColorStorage.border),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        contentPadding: const EdgeInsets.only(left: Sizes.p16, top: Sizes.p10, bottom: Sizes.p10)
                                    ),
                                    onChanged: (val) => setState(() {
                                      name = val;
                                    }),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: Sizes.p24, top: Sizes.p24, bottom: Sizes.p12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(value: TextStorage.titleEmail, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: Sizes.p24, right: Sizes.p24),
                                child:
                                SizedBox(
                                  height: 40,
                                  width: 360,
                                  child: TextField(
                                    style: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.black),
                                    decoration: InputDecoration(
                                        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.black),
                                        hintStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.gray),
                                        hintText: TextStorage.phEmail,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: ColorStorage.border),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: ColorStorage.border),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        contentPadding: const EdgeInsets.only(left: Sizes.p16, top: Sizes.p10, bottom: Sizes.p10)
                                    ),
                                    onChanged: (val) => setState(() {
                                      email = val;
                                    }),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: Sizes.p24, top: Sizes.p24, bottom: Sizes.p12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(value: TextStorage.titlePassword, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding (
                                padding: const EdgeInsets.only(left: Sizes.p24, right: Sizes.p24),
                                child:
                                SizedBox(
                                  height: 40,
                                  width: 360,
                                  child: TextField(
                                    obscureText: _isObscure,
                                    style: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.black),
                                    decoration: InputDecoration(
                                      labelStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.black),
                                      hintStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.gray),
                                      hintText: TextStorage.phPassword,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: ColorStorage.border),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: ColorStorage.border),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: Sizes.p16, top: Sizes.p10, bottom: Sizes.p10),
                                      suffixIcon: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(Sizes.p10),
                                          child: CustomText(value: _isObscure ? TextStorage.lblSee : TextStorage.lblClose),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                    ),
                                    onChanged: (val) => setState(() {
                                      password = val;
                                    }),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: Sizes.p24, top: Sizes.p24, bottom: Sizes.p12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(value: TextStorage.titleConfirmPassword, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding (
                                padding: const EdgeInsets.only(left: Sizes.p24, right: Sizes.p24),
                                child:
                                SizedBox(
                                  height: 40,
                                  width: 360,
                                  child: TextField(
                                    obscureText: _isObscure,
                                    style: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.black),
                                    decoration: InputDecoration(
                                      labelStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.black),
                                      hintStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.gray),
                                      hintText: TextStorage.phConfirmPassword,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: ColorStorage.border),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: ColorStorage.border),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: Sizes.p16, top: Sizes.p10, bottom: Sizes.p10),
                                      suffixIcon: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(Sizes.p10),
                                          child: CustomText(value: _isObscure ? TextStorage.lblSee : TextStorage.lblClose),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                    ),
                                    onChanged: (val) => setState(() {
                                      confirmPassword = val;
                                    }),
                                    onSubmitted: (val) => {
                                      _onRegisterClicked(context)
                                    },
                                  ),
                                ),
                              ),
                              Space.h32,
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.only(left: Sizes.p24, right: Sizes.p24),
                                        child:
                                        TextButton(
                                            onPressed: () {
                                              _onRegisterClicked(context);
                                            },
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                              backgroundColor: ColorStorage.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            child: const CustomText(value: TextStorage.lblRegister, fontWeight: FontWeight.bold, color: Colors.white)
                                        ),
                                      )
                                  ),
                                ],
                              ),
                              Space.h24,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Text(
                                      TextStorage.lblRegistered,
                                      style: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: ColorStorage.blue, decoration: TextDecoration.underline),
                                    ),
                                    onTap: () {
                                      _navigationProvider?.setNavigationItem(NavigationItem.login);
                                    },
                                  ),
                                ],
                              ),
                              Space.h24,
                            ],
                          ),
                        ),
                        Space.h8,
                        CustomText(value: appVersionName, fontSize: 12, color: ColorStorage.gray,),
                        Space.h8,
                      ],
                    ),
                  ],
                )
            ),
          ),
        )
    );
  }
}