import 'package:flutter/material.dart';
import '../components/usuario_card.dart';
import '../models/usuario_model.dart';
import '../services/usuario_service.dart';

class ListUsuariosScreen extends StatefulWidget {
  const ListUsuariosScreen({super.key});

  @override
  State<ListUsuariosScreen> createState() => _ListUsuariosScreenState();
}

class _ListUsuariosScreenState extends State<ListUsuariosScreen> {
  final UsuarioService _service = UsuarioService();
  List<Usuario> _usuarios = [];

  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  void _carregarUsuarios() async {
    try {
      final lista = await _service.getUsuarios();
      setState(() {
        _usuarios = lista;
      });
    } catch (_) {
      // Aqui você pode mostrar uma snackbar de erro
    }
  }

  void _voltar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários Cadastrados')),
      body: _usuarios.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _usuarios.length,
              itemBuilder: (context, index) {
                return UsuarioCard(usuario: _usuarios[index]);
              },
            ),
    );
  }
}
