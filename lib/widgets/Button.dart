import 'dart:ui';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Icon icono;
  final String label;
  final VoidCallback onPressed;

  final estilo = const TextStyle(fontSize: 18);

  const Button(
      {Key? key,
      required this.icono,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: FilledButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(style: estilo, label),
            icono,
          ],
        ),
      ),
    );
  }
}
