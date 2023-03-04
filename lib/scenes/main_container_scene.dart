import 'package:flutter/material.dart';
import 'package:halokak_app/custom/exit_popup.dart';
import 'package:halokak_app/scenes/home/home_scene.dart';

class MainContainerScene extends StatefulWidget {
  const MainContainerScene({super.key});

  @override
  State<MainContainerScene> createState() => _MainContainerScene();

}

class _MainContainerScene extends State<MainContainerScene> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    HomeScene(),
    Icon(
      Icons.camera,
      size: 150,
    ),
  ];

  @override
  void initState() {
    super.initState();
    setupExitCloseWindow(context);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: const Scaffold(
          body: HomeScene(),
        ),
        onWillPop: () => showExitPopup(context));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //       child: Scaffold(
  //         body: Center(
  //           child: _pages.elementAt(_selectedIndex),
  //         ),
  //         bottomNavigationBar: BottomNavigationBar(
  //           items: const <BottomNavigationBarItem>[
  //             BottomNavigationBarItem(
  //               icon: Icon(Icons.home),
  //               label: 'Home',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: Icon(Icons.person),
  //               label: 'Akun',
  //             ),
  //           ],
  //           currentIndex: _selectedIndex,
  //           onTap: _onItemTapped,
  //         ),
  //       ),
  //       onWillPop: () => showExitPopup(context));
  // }
}