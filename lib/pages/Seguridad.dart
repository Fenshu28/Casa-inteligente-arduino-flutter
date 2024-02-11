// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/controllers/ShowDialog.dart';
import 'package:myapp/controllers/bluetooth_controller.dart';
import 'package:myapp/model/datos.dart';

class Seguridad extends StatefulWidget {
  final String? tipo;
  final int paso;
  final BluetoothController blueController;
  const Seguridad(
      {Key? key,
      required this.tipo,
      required this.paso,
      required this.blueController})
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
    if (widget.blueController.connection?.isConnected ?? false) {
      switch (widget.paso) {
        case 1:
          if (_codigoController.text == DatosCasa.codigo) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Seguridad(
                        tipo: "nuevo",
                        paso: 2,
                        blueController: widget.blueController,
                      )),
            );
          } else {
            ShowDialog.showMessage('Error', "Código incorrecto.", context);
          }
          break;
      }
      if (widget.paso == 2) {
        DatosCasa.codigo = _codigoController.text;
        widget.blueController.sendData("1,${_codigoController.text}");
        Navigator.pop(context);
        ShowDialog.showMessage('Completado', "Contraseña guardada.", context);
      }
    } else {
      ShowDialog.showMessage('Error', "no está conectado.", context);
    }
  }
}
