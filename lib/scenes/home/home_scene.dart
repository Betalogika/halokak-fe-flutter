import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halokak_app/custom/custom_text_widget.dart';
import 'package:halokak_app/custom/space.dart';
import 'package:halokak_app/custom/toast.dart';
import 'package:halokak_app/data/local/assets_storage.dart';
import 'package:halokak_app/data/local/color_storage.dart';
import 'package:halokak_app/data/local/text_storage.dart';
import 'package:halokak_app/models/enum/navigation_enum.dart';
import 'package:halokak_app/providers/navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../custom/progress_dialog.dart';
import '../../data/remote/auth_api.dart';
import '../../providers/auth_provider.dart';

class HomeScene extends StatefulWidget {
  const HomeScene({super.key});

  @override
  State<HomeScene> createState() => _HomeScene();
}

class _HomeScene extends State<HomeScene> {
  final AuthAPI _authApi = AuthAPI();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          log(orientation.toString());
          return _homeHorizontal(context);
          // return orientation == Orientation.landscape ? _homeHorizontal(context) : _homeVertical(context);
        },
      )
    );
  }

  void logout() {
    DialogBuilder(context).showLoadingIndicator("");
    if (context.mounted) {
      context.read<AuthProvider>().setUnauthenticated();
      DialogBuilder(context).hideOpenDialog();
    }
  }

  Container _homeHorizontal(BuildContext context) {
    var isAuthenticated = context.select<AuthProvider, bool>((value) => value.isAuthenticated);
    var name = context.select<AuthProvider, String>((value) => value.user?.name ?? TextStorage.lblAnonimUser);
    var photo = context.select<AuthProvider, String>((value) => '');
    FToast fToast = FToast().init(context);
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
                Space.w16,
                Image.asset("assets/ill_logo.jpg"),
                Space.w16,
                InkWell(
                  onTap: () {
                    showToast(context, fToast, TextStorage.errorComingSoon);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CustomText(value: TextStorage.lblHome, fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)
                  ),
                ),
                !isAuthenticated ? Space.empty :
                Space.w16,
                !isAuthenticated ? Space.empty :
                InkWell(
                  onTap: () {
                    showToast(context, fToast, TextStorage.errorComingSoon);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CustomText(value: TextStorage.lblHistory, fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)
                  ),
                ),
                Space.w16,
                InkWell(
                  onTap: () {
                    showToast(context, fToast, TextStorage.errorComingSoon);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CustomText(value: TextStorage.lblArticle, fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)
                  ),
                ),
                Space.w20,
                InkWell(
                  onTap: () {
                    showToast(context, fToast, TextStorage.errorComingSoon);
                  },
                  child: Container(
                    decoration: BoxDecoration(color: ColorStorage.orange, borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10.0, right: 10.0),
                    child: const CustomText(value: TextStorage.lblApplication, fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)
                  ),
                ),
                const Expanded(child: Space.empty,),
                isAuthenticated ? Space.empty :
                InkWell(
                  onTap: () {
                    context.read<NavigationProvider>().setNavigationItem(NavigationItem.login);
                  },
                  child: Container(
                    width: 117,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 30.0, right: 30.0),
                    child: const CustomText(value: TextStorage.lblLogin, fontSize: 16, color: ColorStorage.blue, fontWeight: FontWeight.w500)
                  ),
                ),
                !isAuthenticated ? const SizedBox() :
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showToast(context, fToast, TextStorage.errorComingSoon);
                            },
                            icon: const Icon(Icons.notifications_outlined, color: ColorStorage.blue,),
                        ),
                        Space.w8,
                        CustomText(value: 'Halo, $name', fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500),
                        Space.w8,
                        photo.isNotEmpty == true ? CircleAvatar(
                          backgroundColor: ColorStorage.gray,
                          backgroundImage: (photo.isNotEmpty == true) ? NetworkImage(photo) : null,
                          radius: 15,
                        ) : const Icon(Icons.account_circle_outlined, color: ColorStorage.blue,),
                        PopupMenuButton(
                          onSelected: (value) => {
                            if (value == 1) { logout() }
                            else { showToast(context, fToast, TextStorage.errorComingSoon) }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                                value: 0,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.account_circle_outlined, color: ColorStorage.blue,),
                                    Space.w12,
                                    CustomText(value: TextStorage.lblProfile)
                                  ],
                                )),
                            const PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.logout, color: ColorStorage.blue,),
                                    Space.w12,
                                    CustomText(value: TextStorage.lblLogout)
                                  ],
                                )),
                          ],
                          icon: const Icon(Icons.keyboard_arrow_down, color: ColorStorage.blue,),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 80.0, right: 80.0, top: 70.0),
            child: Row(
              children: [
                const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(value: 'Mentoring', fontSize: 40, color: ColorStorage.blue, fontWeight: FontWeight.bold,),
                            Space.w4,
                            CustomText(value: 'Jadi Lebih', fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold,),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(value: 'Mudah', fontSize: 40, color: ColorStorage.orange, fontWeight: FontWeight.bold,),
                            Space.w4,
                            CustomText(value: 'dan', fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold,),
                            Space.w4,
                            CustomText(value: 'Cepat', fontSize: 40, color: ColorStorage.red, fontWeight: FontWeight.bold,),
                          ],
                        ),
                        Space.h32,
                        CustomText(value: TextStorage.captionHeaderHome, fontSize: 20, color: ColorStorage.gray, fontWeight: FontWeight.w400, lines: 3,),
                        Space.h32
                      ],
                    )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(200),
                      child: Image.asset(AssetsStorage.illHomeHeader, fit: BoxFit.cover,),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            width: double.infinity,
            margin: const EdgeInsets.only(top: 70.0),
            padding: const EdgeInsets.only(top: 24, bottom: 32, left: 80, right: 80),
            child: Row(
              children: [
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text('Pilih Mentor Terbaikmu', style: TextStyle(fontSize: 34, color: Colors.black, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: const [
                        Text('Kategori', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 38,),
                    Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showToast(context, fToast, "Segera Hadir");
                            },
                            child: Container(
                              width: 170,
                              height: 98,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                              child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              showToast(context, fToast, "Segera Hadir");
                            },
                            child: Container(
                              width: 170,
                              height: 98,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                              child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              showToast(context, fToast, "Segera Hadir");
                            },
                            child: Container(
                              width: 170,
                              height: 98,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                              child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              showToast(context, fToast, "Segera Hadir");
                            },
                            child: Container(
                              width: 170,
                              height: 98,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                              child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ]
                    ),
                    const SizedBox(height: 56,),
                    Row(
                      children: const [
                        Text('Direkomendasikan', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 38,),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(200),
                      child: Image.asset(AssetsStorage.illHomeCategory, fit: BoxFit.fitHeight,),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            decoration: const BoxDecoration(color: Colors.white),
            width: double.infinity,
            padding: const EdgeInsets.only(top: 24, bottom: 32, left: 80, right: 80),
            child: Column(
              children: [
                const SizedBox(height: 24,),
                Row(
                    children: [
                      Image.asset("assets/ill_icon.jpg"),
                      const SizedBox(width: 16,),
                      Image.asset("assets/ill_logo.jpg"),
                      const SizedBox(width: 16,),
                    ]
                ),
                const SizedBox(height: 24,),
                const Divider(
                  color: ColorStorage.orange, //color of divider
                  height: 5, //height spacing of divider
                  thickness: 3, //thickness of divier line
                  indent: 48, //spacing at the start of divider
                  endIndent: 48,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16, bottom: 16, left: 48, right: 48),
                  child: Row(
                      children: [
                        const Text('© 2023 copyright HaloKak', style: TextStyle(fontSize: 14, color: ColorStorage.gray, fontWeight: FontWeight.w400)),
                        const Expanded(child: SizedBox(),),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Privacy Policy', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                          ),
                        ),
                        const SizedBox(width: 16,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Term of Use', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
          //preserved for future use
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.only(top: 32, bottom: 32, left: 80, right: 80),
          //   child: Row(
          //     children: [
          //       Expanded(flex: 1,
          //         child:
          //       Container(
          //         margin: const EdgeInsets.only(top: 10.0, bottom: 10),
          //         child: Image.asset(AssetsStorage.illHomeHeader, fit: BoxFit.cover,),
          //       ),),
          //       Expanded(flex: 1, child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: const [
          //           Text('Cari diskon menarik disini', style: TextStyle(fontSize: 34, color: Colors.black, fontWeight: FontWeight.bold)),
          //           SizedBox(height: 20,),
          //           Text('Jangan membuat skillmu tidak berkembang,', style: TextStyle(fontSize: 20, color: ColorStorage.textGray, fontWeight: FontWeight.w400)),
          //           Text('yuk cari ,mentor anda dan lakukan perubahan', style: TextStyle(fontSize: 20, color: ColorStorage.textGray, fontWeight: FontWeight.w400)),
          //         ],
          //       )),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Container _homeVertical(BuildContext context) {
    var isAuthenticated = context.select<AuthProvider, bool>((value) => value.isAuthenticated);
    FToast fToast = FToast().init(context);
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
                    decoration: BoxDecoration(color: ColorStorage.orange, borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10.0, right: 10.0),
                    child: const Text('Aplikasi', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
                  ),
                ),
                const Expanded(child: SizedBox(),),
                isAuthenticated ? const SizedBox() :
                IconButton(
                    onPressed: () {
                      context.read<NavigationProvider>().setNavigationItem(NavigationItem.login);
                    },
                    icon: const Icon(Icons.login)),
                !isAuthenticated ? const SizedBox() :
                IconButton(
                    onPressed: () async {
                      DialogBuilder(context).showLoadingIndicator("");
                      if (context.mounted) {
                        context.read<AuthProvider>().setUnauthenticated();
                        DialogBuilder(context).hideOpenDialog();
                      }
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 80.0, right: 80.0, top: 70.0),
            child: Row(
              children: [
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text('Mentoring', style: TextStyle(fontSize: 40, color: ColorStorage.blue, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4,),
                        Text('Jadi Lebih', style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: const [
                        Text('Mudah', style: TextStyle(fontSize: 40, color: ColorStorage.orange, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4,),
                        Text('dan', style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4,),
                        Text('Cepat', style: TextStyle(fontSize: 40, color: ColorStorage.red, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    const Text('Hubungi mentor, Konsul terkait pekerjaan, Update seputar pekerjaan semua hanya dengan Halo Kak', style: TextStyle(fontSize: 20, color: ColorStorage.gray, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 40,),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(200),
                      child: Image.asset(AssetsStorage.illHomeHeader, fit: BoxFit.cover,),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            width: double.infinity,
            margin: const EdgeInsets.only(top: 70.0),
            padding: const EdgeInsets.only(top: 24, bottom: 32, left: 80, right: 80),
            child: Row(
              children: [
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text('Pilih Mentor Terbaikmu', style: TextStyle(fontSize: 34, color: Colors.black, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: const [
                        Text('Kategori', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 38,),
                    Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showToast(context, fToast, "Segera Hadir");
                            },
                            child: Container(
                              width: 170,
                              height: 98,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                              child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              showToast(context, fToast, "Segera Hadir");
                            },
                            child: Container(
                              width: 170,
                              height: 98,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                              child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              showToast(context, fToast, "Segera Hadir");
                            },
                            child: Container(
                              width: 170,
                              height: 98,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                              child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              showToast(context, fToast, "Segera Hadir");
                            },
                            child: Container(
                              width: 170,
                              height: 98,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                              child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ]
                    ),
                    const SizedBox(height: 56,),
                    Row(
                      children: const [
                        Text('Direkomendasikan', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 38,),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: Container(
                            width: 170,
                            height: 98,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: ColorStorage.blue, width: 1.0)),
                            child: const Text('', style: TextStyle(fontSize: 20, color: ColorStorage.blue, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(200),
                      child: Image.asset(AssetsStorage.illHomeCategory, fit: BoxFit.fitHeight,),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            decoration: const BoxDecoration(color: Colors.white),
            width: double.infinity,
            padding: const EdgeInsets.only(top: 24, bottom: 32, left: 80, right: 80),
            child: Column(
              children: [
                const SizedBox(height: 24,),
                Row(
                    children: [
                      Image.asset("assets/ill_icon.jpg"),
                      const SizedBox(width: 16,),
                      Image.asset("assets/ill_logo.jpg"),
                      const SizedBox(width: 16,),
                    ]
                ),
                const SizedBox(height: 24,),
                const Divider(
                  color: ColorStorage.orange, //color of divider
                  height: 5, //height spacing of divider
                  thickness: 3, //thickness of divier line
                  indent: 48, //spacing at the start of divider
                  endIndent: 48,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16, bottom: 16, left: 48, right: 48),
                  child: Row(
                      children: [
                        const Text('© 2023 copyright HaloKak', style: TextStyle(fontSize: 14, color: ColorStorage.gray, fontWeight: FontWeight.w400)),
                        const Expanded(child: SizedBox(),),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Privacy Policy', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                          ),
                        ),
                        const SizedBox(width: 16,),
                        InkWell(
                          onTap: () {
                            showToast(context, fToast, "Segera Hadir");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Term of Use', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
          //preserved for future use
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.only(top: 32, bottom: 32, left: 80, right: 80),
          //   child: Row(
          //     children: [
          //       Expanded(flex: 1,
          //         child:
          //       Container(
          //         margin: const EdgeInsets.only(top: 10.0, bottom: 10),
          //         child: Image.asset(AssetsStorage.illHomeHeader, fit: BoxFit.cover,),
          //       ),),
          //       Expanded(flex: 1, child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: const [
          //           Text('Cari diskon menarik disini', style: TextStyle(fontSize: 34, color: Colors.black, fontWeight: FontWeight.bold)),
          //           SizedBox(height: 20,),
          //           Text('Jangan membuat skillmu tidak berkembang,', style: TextStyle(fontSize: 20, color: ColorStorage.textGray, fontWeight: FontWeight.w400)),
          //           Text('yuk cari ,mentor anda dan lakukan perubahan', style: TextStyle(fontSize: 20, color: ColorStorage.textGray, fontWeight: FontWeight.w400)),
          //         ],
          //       )),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}