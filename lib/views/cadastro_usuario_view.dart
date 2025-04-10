import 'package:flutter/material.dart';
import '../controllers/usuario_controller.dart';

class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({super.key});

  @override
  _CadastroUsuarioViewState createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final UsuarioController _controller = UsuarioController();

  void _cadastrarUsuario() async {
    final login = _loginController.text;
    final senha = _senhaController.text;
    await _controller.cadastrarUsuario(login, senha);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuário cadastrado com sucesso!')),
    );
    _loginController.clear();
    _senhaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Cadastrar'),
              onPressed: _cadastrarUsuario,
            )
          ],
        ),
      ),
    );
  }
}
