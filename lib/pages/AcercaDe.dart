import 'package:flutter/material.dart';

class AcercaDe extends StatelessWidget {
  const AcercaDe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Desarrollado por:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Arleth Machuca Fabian',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Cristopher Alexis Zarate Valencia',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Correo electrónico:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'fenshu28@gmail.com',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Versión:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '0.0.1',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
