import 'package:flutter/material.dart';
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
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Column(
          children: [
            Text('Nama: ${auth.user?.name}'),
            TextButton(onPressed: logout, child: const Text("Logout"))
          ],
        );
      },
    );
  }

}