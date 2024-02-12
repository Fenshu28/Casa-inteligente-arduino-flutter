import 'package:flutter/material.dart';
import 'package:myapp/model/datos.dart';
import 'package:myapp/pages/MainPage.dart';
import 'package:myapp/widgets/TextBox.dart';
import 'package:myapp/widgets/Button.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController _usr = new TextEditingController();
  TextEditingController _psw = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(image: AssetImage("assets/images/logo.png")),
            // TextBox(label: 'Usuario', _usr),
            TextBox(label: 'Constraseña', _psw, isPassword: true),
            Button(
                icono: const Icon(Icons.arrow_forward_rounded),
                label: "Acceder",
                onPressed: () {
                  if (_psw.text == DatosCasa.codigo) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPage(
                                  key: key,
                                )));
                  }
                }),
          ],
        ),
      )),
    );
  }
}
