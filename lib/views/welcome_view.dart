import 'package:flutter/material.dart';
import 'cadastro_usuario_view.dart';
import 'enderecos_view.dart'; // redireciona para a tela principal após login
import '../controllers/usuario_controller.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final UsuarioController _controller = UsuarioController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _logar() async {
    final login = _loginController.text;
    final senha = _senhaController.text;

    final usuario = await _controller.authenticate(login, senha);

    if (usuario != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EnderecosView()),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Erro de login'),
          content: const Text('Login ou senha inválidos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _cadastrar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroUsuarioView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem-vindo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _logar, child: const Text('Entrar')),
                ElevatedButton(
                  onPressed: _cadastrar,
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
