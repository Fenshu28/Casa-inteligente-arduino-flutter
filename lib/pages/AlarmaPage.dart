import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/controllers/bluetooth_controller.dart';
import 'package:myapp/model/datos.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AlarmaPage extends StatefulWidget {
  BluetoothController blueController = BluetoothController();
  AlarmaPage({required this.blueController, super.key});

  @override
  State<AlarmaPage> createState() => _AlarmaPageState();
}

class _AlarmaPageState extends State<AlarmaPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 172, 121, 240),
        title: const Text(
          'Activar alarma',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              width: 50,
            ),
            Text("Alarma",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 28,
                        fontWeight: FontWeight.w600))),
            const SizedBox(
              width: 15,
            ),
            switchAlarma(),
          ],
        ),
      ),
    );
  }

  FlutterSwitch switchAlarma() {
    return
        // Switch(
        //     value: DatosCasa.isBloqueado,
        //     onChanged: (value) {
        //       setState(() {
        //         DatosCasa.isBloqueado = value;
        //         widget.blueController.sendData("2,${DatosCasa.isBloqueado}");
        //       });
        //     });
        FlutterSwitch(
      width: 125.0,
      height: 55.0,
      valueFontSize: 25.0,
      toggleSize: 45.0,
      value: DatosCasa.isBloqueado,
      borderRadius: 30.0,
      padding: 8.0,
      activeColor: Color.fromARGB(255, 0, 204, 68),
      showOnOff: true,
      onToggle: (val) {
        setState(() {
          DatosCasa.isBloqueado = val;
          widget.blueController.sendData("2,${DatosCasa.isBloqueado}");
        });
      },
    );
  }
}
