import 'package:flutter/material.dart';
import 'package:myapp/controllers/NotfiService.dart';
import 'package:myapp/controllers/bluetooth_controller.dart';
import 'package:myapp/model/datos.dart';
import 'package:myapp/pages/AcercaDe.dart';
import 'package:myapp/pages/AlarmaPage.dart';
import 'package:myapp/pages/ConfigPage.dart';
import 'package:myapp/pages/Dashboard.dart';
import 'package:myapp/pages/Seguridad.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  BluetoothController blueController = BluetoothController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void receiveData() {
    blueController.connection?.input?.listen((event) {
      String data = String.fromCharCodes(event);
      if (data.isNotEmpty) {
        List<String> values = data.split(",");
        // print(values[0]);
        switch (int.parse(values[0])) {
          case 0:
            setState(() {
              DatosCasa.temperatura = double.parse(values[1]);
              DatosCasa.humedad = double.parse(values[2]);
              // print(values[1]);
            });

            break;
          case 1:
            // setState(() {
            print(values[1]);

            // if (DatosCasa.isVTemp != bool.parse(values[1])) {
            //   DatosCasa.isViolado = bool.parse(values[1]);
            //   DatosCasa.isVTemp = bool.parse(values[1]);
            if (values[1].toString().contains("true")) {
              NotificationService().showNotification(
                  title: 'Alertaaaa',
                  body: 'Te estan robando!! llamando a los bomberos');
            }
            // print(values[1]);
            // }
            // });
            break;
          case 2:
            setState(() {
              DatosCasa.isBloqueado = bool.parse(values[1]);
              // print(values[1]);
            });
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 198, 162, 245),
      drawer: Drawer(
        child: burggerMenu(context),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 172, 121, 240),
        title: const Text(
          'Home control',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 20),
          GridDashboard(),
          const SizedBox(
            height: 500,
          )
        ],
      )),
    );
  }

  Switch switchAlarma() {
    return Switch(
        value: DatosCasa.isBloqueado,
        onChanged: (value) {
          setState(() {
            DatosCasa.isBloqueado = value;
            blueController.sendData("2,${DatosCasa.isBloqueado}");
          });
        });
    // FlutterSwitch(
    //   width: 125.0,
    //   height: 55.0,
    //   valueFontSize: 25.0,
    //   toggleSize: 45.0,
    //   value: DatosCasa.isBloqueado,
    //   borderRadius: 30.0,
    //   padding: 8.0,
    //   activeColor: Color.fromARGB(255, 0, 204, 68),
    //   showOnOff: true,
    //   onToggle: (val) {
    //     setState(() {
    //       DatosCasa.isBloqueado = val;
    //       blueController.sendData("2,${DatosCasa.isBloqueado}");
    //     });
    //   },
    // );
  }

  Padding burggerMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Principal"),
            onTap: () {
              receiveData();
            },
          ),
          ExpansionTile(
              leading: const Icon(Icons.security),
              title: const Text("Seguridad"),
              children: [
                ListTile(
                  leading: const SizedBox(),
                  title: const Text("Cambiar código"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Seguridad(
                                  tipo: "actual",
                                  paso: 1,
                                  blueController: blueController,
                                )));
                  },
                ),
                ListTile(
                  leading: const SizedBox(),
                  title: const Text("Alarma"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AlarmaPage(blueController: blueController)));
                  },
                ),
              ]),
          ListTile(
            leading: const Icon(Icons.settings_bluetooth),
            title: const Text("Configuraciones bluetooth"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ConfigPage(blueController: blueController)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Acerca de"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AcercaDe()));
            },
          ),
        ],
      ),
    );
  }
}
