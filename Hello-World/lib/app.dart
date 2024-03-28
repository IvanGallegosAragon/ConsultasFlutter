import 'package:flutter/material.dart';
//import 'vistas/HomePage.dart';
//import 'vistas/calc.dart';
import 'nav.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App!!',
      theme: ThemeData(
        colorSchemeSeed: Color(0xff172158),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const Navegador(),
      debugShowCheckedModeBanner: false,
    );
  }
}
