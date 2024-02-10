import 'package:flutter/material.dart';

class ShowDialog {
  static void showMessage(String title, String message,BuildContext context) {
    // Code to show the message on the screen

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  const Text("OK"),
          ),
        ],
      ),
    );
  }
}
