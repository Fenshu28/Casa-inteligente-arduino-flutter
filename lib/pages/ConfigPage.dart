import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:myapp/controllers/bluetooth_controller.dart';

// ignore: must_be_immutable
class ConfigPage extends StatefulWidget {
  BluetoothController blueController = BluetoothController();
  ConfigPage({required this.blueController, super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late final BluetoothController blueController;

  @override
  void initState() {
    super.initState();

    blueController = widget.blueController;

    blueController.requestPermission();

    blueController.bluetooth.state.then((state) {
      setState(() => blueController.bluetoothState = state.isEnabled);
    });

    blueController.bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => blueController.bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => blueController.bluetoothState = true);
          break;
        // case BluetoothState.STATE_TURNING_OFF:
        //   break;
        // case BluetoothState.STATE_TURNING_ON:
        //   break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configuraciones bluetooth'),
      ),
      body: Column(
        children: [
          _controlBT(),
          _infoDevice(),
          Expanded(child: _listDevices()),
          // _inputSerial(),
          // _buttons(),
        ],
      ),
    );
  }

  Widget _controlBT() {
    return SwitchListTile(
      value: blueController.bluetoothState,
      onChanged: (bool value) async {
        if (value) {
          await blueController.bluetooth.requestEnable();
        } else {
          await blueController.bluetooth.requestDisable();
        }
      },
      tileColor: Colors.black26,
      title: Text(
        blueController.bluetoothState
            ? "Bluetooth encendido"
            : "Bluetooth apagado",
      ),
    );
  }

  Widget _infoDevice() {
    return ListTile(
      tileColor: Colors.black12,
      title: Text(
          "Conectado a: ${blueController.deviceConnected?.name ?? "ninguno"}"),
      trailing: blueController.connection?.isConnected ?? false
          ? TextButton(
              onPressed: () async {
                await blueController.connection?.finish();
                setState(() => blueController.deviceConnected = null);
              },
              child: const Text("Desconectar"),
            )
          : TextButton(
              onPressed: blueController.getDevices,
              child: const Text("Ver dispositivos"),
            ),
    );
  }

  Widget _listDevices() {
    return blueController.isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  ...[
                    for (final device in blueController.devices)
                      ListTile(
                        title: Text(device.name ?? device.address),
                        trailing: TextButton(
                          child: const Text('conectar'),
                          onPressed: () async {
                            setState(() => blueController.isConnecting = true);

                            blueController.connection =
                                await BluetoothConnection.toAddress(
                                    device.address);
                            blueController.deviceConnected = device;
                            blueController.devices = [];
                            blueController.isConnecting = false;

                            blueController.receiveData();

                            setState(() {});
                          },
                        ),
                      )
                  ]
                ],
              ),
            ),
          );
  }

  Widget _inputSerial() {
    return ListTile(
      trailing: TextButton(child: const Text('reiniciar'), onPressed: () => {}
          // setState(() => times = 0),
          ),
      title: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          "Pulsador presionado (x)",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
      color: Colors.black12,
      child: const Column(
        children: [
          Text('Controles para LED', style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 16.0),
          Row(
            children: [
              // Expanded(
              //   child: ActionButton(
              //     text: "Encender",
              //     color: Colors.green,
              //     onTap: () => _sendData("1"),
              //   ),
              // ),
              // const SizedBox(width: 8.0),
              // Expanded(
              //   child: ActionButton(
              //     color: Colors.red,
              //     text: "Apagar",
              //     onTap: () => _sendData("0"),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
