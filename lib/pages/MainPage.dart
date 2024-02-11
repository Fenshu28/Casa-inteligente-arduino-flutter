import 'package:flutter/material.dart';
import 'package:myapp/controllers/bluetooth_controller.dart';
import 'package:myapp/model/datos.dart';
import 'package:myapp/pages/AcercaDe.dart';
import 'package:myapp/pages/ConfigPage.dart';
import 'package:myapp/pages/Dashboard.dart';
import 'package:myapp/pages/Seguridad.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

        switch (int.parse(values[0])) {
          case 0:
            setState(() {
              DatosCasa.temperatura = double.parse(values[1]);
              DatosCasa.humedad = double.parse(values[2]);
              print(values[1]);
            });

            break;
          case 1:
            setState(() {
              DatosCasa.isAutentecado = bool.parse(values[1]);
            });
            break;
        }

        // DatosCasa.isAutentecado = bool.parse(values[2]);
        // DatosCasa.isAlarma = bool.parse(values[3]);
        // DatosCasa.isPuerta = bool.parse(values[4]);
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
        children: [const SizedBox(height: 20), GridDashboard()],
      )),
    );
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
                  title: const Text("Acceso al hogar"),
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
                  title: const Text("Alertas de seguridad"),
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
                )
              ]),
          const ExpansionTile(
              leading: Icon(Icons.broadcast_on_home_rounded),
              title: Text("Entorno del hogar"),
              children: [
                ListTile(
                  leading: SizedBox(),
                  title: Text("Temperatura"),
                ),
                ListTile(
                  leading: SizedBox(),
                  title: Text("Humedad"),
                )
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
