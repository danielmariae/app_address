import 'package:app_address/services/endereco_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EnderecoService()..carregarEnderecos()),
        ],
        child: const MyApp(),
      ),
    );
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