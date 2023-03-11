import 'package:flutter/material.dart';
import 'package:halokak_app/data/database/base_db.dart';
import 'package:halokak_app/data/local/text_storage.dart';
import 'package:halokak_app/providers/auth_provider.dart';
import 'package:halokak_app/scenes/authentication/login_scene.dart';
import 'package:halokak_app/scenes/main_container_scene.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'configs/environment.dart';

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
    // AuthProvider authProvider = Provider.of(context);
    Widget body = const MainContainerScene();
    // if (authProvider.isAuthenticated) {
    //   body = const MainContainerScene();
    // } else {
    //   body = const LoginScene();
    // }
    return MaterialApp(
      title: TextStorage.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: body,
    );
  }
}
