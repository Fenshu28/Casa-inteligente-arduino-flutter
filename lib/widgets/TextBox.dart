import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController edController;

  const TextBox(this.edController,
      {this.isPassword = false, Key? key, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          controller: edController,
          obscureText: isPassword,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: label)),
    );
  }
}
