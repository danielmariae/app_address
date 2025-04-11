import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AddressApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WelcomeScreen(), // Tela pública inicial
    );
  }
}