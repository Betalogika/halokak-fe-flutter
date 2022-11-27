import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:halokak_app/data/local/text_storage.dart';
import 'package:halokak_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void setupExitCloseWindow(context) {
  if (kIsWeb) {
    FlutterWindowClose.setWebReturnValue(TextStorage.captionSure);
    return;
  }
  FlutterWindowClose.setWindowShouldCloseHandler(() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text(TextStorage.captionExitApp),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      AuthProvider authProvider = Provider.of(context, listen: false);
                      authProvider.closeDB();
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade800),
                    child: const Text(TextStorage.lblYes)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(TextStorage.lblNo))
              ]);
        });
  });
}

Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text(TextStorage.captionExitApp),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    AuthProvider authProvider = Provider.of(context, listen: false);
                    authProvider.closeDB();
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade800),
                  child: const Text(TextStorage.lblYes)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(TextStorage.lblNo))
            ]);
      });
}