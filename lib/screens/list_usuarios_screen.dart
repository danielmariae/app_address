import 'package:flutter/material.dart';
import '../components/usuario_card.dart';
import '../models/usuario_model.dart';
import '../services/usuario_service.dart';

class ListUsuariosScreen extends StatelessWidget {
  const ListUsuariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários Cadastrados')),
      body: FutureBuilder<List<Usuario>>(
        future: UsuarioService().getUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar usuários'));
          }
          final usuarios = snapshot.data ?? [];
          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              return UsuarioCard(usuario: usuarios[index]);
            },
          );
        },
      ),
    );
  }
}
