import 'package:flutter/material.dart';
import 'package:myapp/controllers/bluetooth_controller.dart';
import 'package:myapp/model/datos.dart';
import 'package:myapp/pages/AcercaDe.dart';
import 'package:myapp/pages/ConfigPage.dart';
import 'package:myapp/pages/Seguridad.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BluetoothController blueController = BluetoothController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: burggerMenu(context),
      ),
      appBar: AppBar(
        title: const Text('Home control'),
      ),
      body: Center(
          child: Column(
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                blueController.receiveData();
              });
            },
          ),
          const SizedBox(height: 20),
          Text("Temperatura: ${DatosCasa.temperature}"),
          Text("Humedad: ${DatosCasa.humedad}"),
        ],
      )),
    );
  }

  Padding burggerMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          const ListTile(leading: Icon(Icons.home), title: Text("Principal")),
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
                            builder: (context) => const Seguridad()));
                  },
                ),
                ListTile(
                  leading: const SizedBox(),
                  title: const Text("Alertas de seguridad"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Seguridad()));
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
