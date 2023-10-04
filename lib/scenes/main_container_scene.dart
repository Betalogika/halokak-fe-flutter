import 'package:flutter/material.dart';
import 'package:halokak_app/custom/exit_popup.dart';
import 'package:halokak_app/scenes/home/home_scene.dart';

class MainContainerScene extends StatefulWidget {
  const MainContainerScene({super.key});

  @override
  State<MainContainerScene> createState() => _MainContainerScene();

}

class _MainContainerScene extends State<MainContainerScene> {

  @override
  void initState() {
    super.initState();
    setupExitCloseWindow(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: const Scaffold(
          body: HomeScene(),
        ),
        onWillPop: () => showExitPopup(context));
  }
}