import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halokak_app/custom/toast.dart';
import 'package:halokak_app/data/local/color_storage.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class HomeScene extends StatefulWidget {
  const HomeScene({super.key});

  @override
  State<HomeScene> createState() => _HomeScene();
}

class _HomeScene extends State<HomeScene> {
  AuthProvider? authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of(context, listen: false);
  }

  void logout() async {
    authProvider?.setUnauthenticated();
  }

  @override
  Widget build(BuildContext context) {
    FToast fToast = FToast().init(context);
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Container(
          decoration: const BoxDecoration(color: ColorStorage.bgDefault),
          width: double.infinity,
          child:  Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0),
                padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 24.0, bottom: 24.0),
                child: Row(
                  children: [
                    Image.asset("assets/ill_icon.jpg"),
                    const SizedBox(width: 16,),
                    Image.asset("assets/ill_logo.jpg"),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: () {
                        showToast(context, fToast, "Segera Hadir");
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Beranda', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: () {
                        showToast(context, fToast, "Segera Hadir");
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Riwayat', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: () {
                        showToast(context, fToast, "Segera Hadir");
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Artikel', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: () {
                        showToast(context, fToast, "Segera Hadir");
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.deepOrangeAccent, borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10.0, right: 10.0),
                        child: const Text('Aplikasi', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const Expanded(child: SizedBox(),),
                    InkWell(
                      onTap: () {
                        showToast(context, fToast, "Segera Hadir");
                      },
                      child: Container(
                        width: 117,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 30.0, right: 30.0),
                        child: const Text('Login', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}