import 'package:flutter/material.dart';
import '../components/endereco_card.dart';
import '../models/endereco_model.dart';
import '../services/endereco_service.dart';
import 'cadastro_endereco_screen.dart';
import 'editar_endereco_screen.dart';
import 'list_usuarios_screen.dart';
import 'welcome_screen.dart';

class EnderecosScreen extends StatefulWidget {
  const EnderecosScreen({super.key});

  @override
  State<EnderecosScreen> createState() => _EnderecosScreenState();
}

class _EnderecosScreenState extends State<EnderecosScreen> {
  final EnderecoService _service = EnderecoService();
  List<Endereco> _enderecos = [];

  @override
  void initState() {
    super.initState();
    _carregarEnderecos();
  }

  void _carregarEnderecos() async {
    final lista = await _service.getEnderecos();
    setState(() {
      _enderecos = lista;
    });
  }

  void _adicionarEndereco() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroEnderecoScreen()),
    );
    _carregarEnderecos();
  }

  void _editarEndereco(Endereco endereco) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditarEnderecoScreen(
          endereco: endereco,
          onEdit: _carregarEnderecos,
        ),
      ),
    );
  }

  void _excluirEndereco(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir Endereço'),
        content: const Text('Deseja realmente excluir este endereço?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _service.deleteEndereco(id);
      _carregarEnderecos();
    }
  }

  void _irParaUsuarios() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ListUsuariosScreen()),
    );
  }

  void _deslogar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Endereços')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              title: const Text('Listar Usuários'),
              onTap: _irParaUsuarios,
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: _deslogar,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _enderecos.length,
        itemBuilder: (context, index) {
          final e = _enderecos[index];
          return EnderecoCard(
            endereco: e,
            onEdit: () => _editarEndereco(e),
            onDelete: () => _excluirEndereco(e.id!),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarEndereco,
        child: const Icon(Icons.add),
      ),
    );
  }
}
