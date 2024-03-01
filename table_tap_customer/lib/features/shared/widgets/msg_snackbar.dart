import 'package:flutter/material.dart';

class MsgSnackBar {
  static void show(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: color,
        content: Text(msg),
      ),
    );
  }
}
