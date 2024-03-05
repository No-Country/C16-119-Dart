import 'package:flutter/material.dart';

void messageDialogSucces(
    BuildContext context, final String message, final String? title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null ? Text(title, textAlign: TextAlign.center) : null,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}
