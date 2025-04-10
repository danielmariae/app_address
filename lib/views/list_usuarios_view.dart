import 'package:flutter/material.dart';
import '../controllers/usuario_controller.dart';
import '../models/usuario_model.dart';

class ListUsuariosView extends StatelessWidget {
  final UsuarioController _controller = UsuarioController();

  ListUsuariosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuários Cadastrados')),
      body: FutureBuilder<List<Usuario>>(
        future: _controller.listarUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar usuários'));
          }
          final usuarios = snapshot.data ?? [];
          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return ListTile(
                title: Text(usuario.login),
              );
            },
          );
        },
      ),
    );
  }
}
