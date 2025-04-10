import 'package:app_address/views/editar_endereco_view.dart';
import 'package:flutter/material.dart';
import '../controllers/endereco_controller.dart';
import '../models/endereco_model.dart';
import './cadastro_endereco_view.dart';
import './list_usuarios_view.dart';
import './welcome_view.dart';

class EnderecosView extends StatefulWidget {
  const EnderecosView({super.key});

  @override
  State<EnderecosView> createState() => _EnderecosViewState();
}

class _EnderecosViewState extends State<EnderecosView> {
  void _refresh() {
    setState(() {});
  }

  final EnderecoController _controller = EnderecoController();
  List<Endereco> _enderecos = [];

  @override
  void initState() {
    super.initState();
    _carregarEnderecos();
  }

  void _carregarEnderecos() async {
    final lista = await _controller.listarEnderecos();
    setState(() {
      _enderecos = lista;
    });
  }

  void _deslogar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeView()),
    );
  }

  void _navegarParaUsuarios() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ListUsuariosView()),
    );
  }

  void _adicionarEndereco() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroEnderecoView()),
    );
    _carregarEnderecos();
  }

  void _editarEndereco(Endereco endereco) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditarEnderecoView(
          endereco: endereco,
          onEdit: _refresh,
        ),
      ),
    );
    _carregarEnderecos();
  }

  void _excluirEndereco(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir Endereço'),
        content: const Text(
          'Tem certeza que deseja excluir este endereço?',
        ),
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
      await _controller.deleteEndereco(id);
      _carregarEnderecos();
    }
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
              onTap: _navegarParaUsuarios,
            ),
            ListTile(title: const Text('Sair'), onTap: _deslogar),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _enderecos.length,
        itemBuilder: (context, index) {
          final e = _enderecos[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${e.logradouro}, ${e.numeroLote}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${e.bairro} - ${e.localidade}/${e.uf}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editarEndereco(e),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _excluirEndereco(e.id!),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
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
