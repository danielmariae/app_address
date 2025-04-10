import 'package:flutter/material.dart';
import '../controllers/endereco_controller.dart';
import '../models/endereco_model.dart';

class CadastroEnderecoView extends StatefulWidget {
  final Endereco? endereco; // <- adicione isso

  const CadastroEnderecoView({super.key, this.endereco}); // <- atualize aqui

  @override
  State<CadastroEnderecoView> createState() => _CadastroEnderecoViewState();
}

class _CadastroEnderecoViewState extends State<CadastroEnderecoView> {
  final _cepController = TextEditingController();
  final _numeroLoteController = TextEditingController();
  final _complementoController = TextEditingController();

  final EnderecoController _controller = EnderecoController();
  Endereco? _enderecoPreenchido;

  void _buscarEndereco() async {
    final cep = _cepController.text;
    try {
      final endereco = await _controller.buscarEnderecoPorCep(cep);
      setState(() {
        _enderecoPreenchido = endereco;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar o endereço')),
      );
    }
  }

  void _cadastrarEndereco() async {
    if (_enderecoPreenchido == null) return;
    final endereco = Endereco(
      cep: _cepController.text,
      logradouro: _enderecoPreenchido!.logradouro,
      numeroLote: _numeroLoteController.text,
      complemento: _complementoController.text,
      bairro: _enderecoPreenchido!.bairro,
      uf: _enderecoPreenchido!.uf,
      localidade: _enderecoPreenchido!.localidade,
    );
    await _controller.cadastrarEndereco(endereco);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Endereço cadastrado com sucesso!')),
    );
    _cepController.clear();
    _numeroLoteController.clear();
    _complementoController.clear();
    setState(() {
      _enderecoPreenchido = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Endereço')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _cepController,
              decoration: InputDecoration(
                labelText: 'CEP',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _buscarEndereco,
                ),
              ),
            ),
            if (_enderecoPreenchido != null) ...[
              SizedBox(height: 16),
              Text('Logradouro: ${_enderecoPreenchido!.logradouro}'),
              Text('Bairro: ${_enderecoPreenchido!.bairro}'),
              Text('Localidade: ${_enderecoPreenchido!.localidade}'),
              Text('UF: ${_enderecoPreenchido!.uf}'),
            ],
            TextField(
              controller: _numeroLoteController,
              decoration: InputDecoration(labelText: 'Número/Lote'),
            ),
            TextField(
              controller: _complementoController,
              decoration: InputDecoration(labelText: 'Complemento'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Cadastrar Endereço'),
              onPressed: _cadastrarEndereco,
            ),
          ],
        ),
      ),
    );
  }
}
