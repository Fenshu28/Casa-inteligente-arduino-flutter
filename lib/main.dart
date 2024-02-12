import 'package:flutter/material.dart';
import 'package:myapp/controllers/NotfiService.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:myapp/pages/MainPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Home control',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              //Definimos el color principal de la aplicación.
              seedColor: const Color.fromARGB(255, 218, 126, 236)),
          useMaterial3: true,
        ),
        home: const MainPage(),
        //LoginView(),
      ),
    );
    // MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const MainPage(),
    // );
  }
}
