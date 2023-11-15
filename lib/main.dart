import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halokak_app/data/database/base_db.dart';
import 'package:halokak_app/data/local/color_storage.dart';
import 'package:halokak_app/data/local/text_storage.dart';
import 'package:halokak_app/models/enum/navigation_enum.dart';
import 'package:halokak_app/providers/auth_provider.dart';
import 'package:halokak_app/providers/home_provider.dart';
import 'package:halokak_app/providers/navigation_provider.dart';
import 'package:halokak_app/scenes/authentication/login_scene.dart';
import 'package:halokak_app/scenes/authentication/register_scene.dart';
import 'package:halokak_app/scenes/main_container_scene.dart';
import 'package:provider/provider.dart';

import 'configs/environment.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BaseDB().setupDB();
  Environment().initConfig(const String.fromEnvironment('ENVIRONMENT', defaultValue: Environment.STAGING));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => NavigationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeProvider(),
          )
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationItem = context.select<NavigationProvider, NavigationItem>((value) => value.navigationItem);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TextStorage.appName,
      theme: ThemeData(
        primarySwatch: ColorStorage.mcBlue,
        dividerColor: Colors.transparent,
      ),
      home: navigationItem == NavigationItem.login ? const LoginScene() :
          navigationItem == NavigationItem.register ? const RegisterScene() : const MainContainerScene(),
    );
  }
}
