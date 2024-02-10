// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/controllers/ShowDialog.dart';

class Seguridad extends StatefulWidget {
  final String? tipo;
  final int paso;
  const Seguridad({Key? key, required this.tipo, required this.paso})
      : super(key: key);

  @override
  State<Seguridad> createState() => _SeguridadState();
}

class _SeguridadState extends State<Seguridad> {
  final _formKey = GlobalKey<FormState>();
  final _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
            const Text("Cambia el código de seguridad",
                style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                maxLength: 4,
                keyboardType: TextInputType.number,
                controller: _codigoController,
                decoration: InputDecoration(
                  labelText: "Código ${widget.tipo}",
                ),
                validator: (value) => valida(value!),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  cambiarPanel();
                }
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }

  String? valida(String value) {
    if (value.isEmpty) {
      return 'Por favor, introduzca el código de seguridad.';
    } else if (value.length < 4) {
      return 'El código debe tener 4 digitos.';
    }
    return null;
  }

  void cambiarPanel() {
    switch (widget.paso) {
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Seguridad(
                    tipo: "nuevo",
                    paso: 2,
                  )),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Seguridad(
                    tipo: "confirmación",
                    paso: 3,
                  )),
        );
        break;
    }
    if (widget.paso == 3) {
      Navigator.pop(context);
      ShowDialog.showMessage('Completado', "Contraseña guardada.", context);
    }
  }
}
