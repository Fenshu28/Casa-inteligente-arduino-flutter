import 'package:flutter/material.dart';

class Seguridad extends StatefulWidget {
  const Seguridad({Key? key}) : super(key: key);

  @override
  State<Seguridad> createState() => _SeguridadState();
}

class _SeguridadState extends State<Seguridad> {
  final _formKey = GlobalKey<FormState>();
  final _codigoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguridad'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                maxLength: 4,
                keyboardType: TextInputType.number,
                controller: _codigoController,
                decoration: const InputDecoration(
                  labelText: 'Código de seguridad',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduzca el código de seguridad.';
                  } else if (value.length < 4) {
                    return 'El código debe tener 4 digitos.';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Aquí se llamaría a la función para bloquear la puerta
                }
              },
              child: const Text('Asignar codigo de bloqueo'),
            ),
          ],
        ),
      ),
    );
  }
}
