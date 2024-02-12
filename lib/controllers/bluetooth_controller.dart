import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:myapp/model/datos.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController {
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;

  get bluetooth => _bluetooth;

  bool get bluetoothState => _bluetoothState;
  set bluetoothState(bool value) {
    _bluetoothState = value;
  }

  bool get isConnecting => _isConnecting;
  set isConnecting(bool value) {
    _isConnecting = value;
  }

  BluetoothConnection? get connection => _connection;
  set connection(BluetoothConnection? value) {
    _connection = value;
  }

  List<BluetoothDevice> get devices => _devices;
  set devices(List<BluetoothDevice> value) {
    _devices = value;
  }

  BluetoothDevice? get deviceConnected => _deviceConnected;
  set deviceConnected(BluetoothDevice? value) {
    _deviceConnected = value;
  }

  void getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    _devices = res;
    
  }

  void receiveData() {
    _connection?.input?.listen((event) {
      String data = String.fromCharCodes(event);
      if (data.isNotEmpty) {
        List<String> values = data.split(",");

        switch (int.parse(values[0])) {
          case 0:
            DatosCasa.temperatura = double.parse(values[1]);
            DatosCasa.humedad = double.parse(values[2]);
            break;
        }

        // DatosCasa.isAutentecado = bool.parse(values[2]);
        // DatosCasa.isAlarma = bool.parse(values[3]);
        // DatosCasa.isPuerta = bool.parse(values[4]);
      }
    });
  }

  void sendData(String data) {
    if (_connection?.isConnected ?? false) {
      _connection?.output.add(ascii.encode(data));
    }
  }

  void requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }
}
