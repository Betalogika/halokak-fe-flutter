import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';


void showToast(BuildContext context, FToast fToast, String message) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.info),
        const SizedBox(
          width: 12.0,
        ),
        Text(message),
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}