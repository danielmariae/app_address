import 'package:flutter/material.dart';
import '../../models/endereco_model.dart';
import '../../services/endereco_service.dart';

class CadastroEnderecoScreen extends StatefulWidget {
  const CadastroEnderecoScreen({super.key});

  @override
  State<CadastroEnderecoScreen> createState() => _CadastroEnderecoScreenState();
}

class _CadastroEnderecoScreenState extends State<CadastroEnderecoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _localidadeController = TextEditingController();
  final _ufController = TextEditingController();

  final _service = EnderecoService();

  void _buscarCep() async {
    try {
      final endereco = await _service.getEnderecoByCep(_cepController.text);
      setState(() {
        _logradouroController.text = endereco!.logradouro;
        _bairroController.text = endereco!.bairro;
        _localidadeController.text = endereco!.localidade;
        _ufController.text = endereco!.uf;
      });
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CEP inválido ou não encontrado')),
      );
    }
  }

  void _salvarEndereco() async {
    if (_formKey.currentState!.validate()) {
      final novoEndereco = Endereco(
        cep: _cepController.text,
        logradouro: _logradouroController.text,
        numeroLote: _numeroController.text,
        complemento: _complementoController.text,
        bairro: _bairroController.text,
        localidade: _localidadeController.text,
        uf: _ufController.text,
      );
      await _service.addEndereco(novoEndereco);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Endereço')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _cepController,
                decoration: const InputDecoration(labelText: 'CEP'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Informe o CEP' : null,
              ),
              ElevatedButton(
                onPressed: _buscarCep,
                child: const Text('Buscar CEP'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _logradouroController,
                decoration: const InputDecoration(labelText: 'Logradouro'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o logradouro' : null,
              ),
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(labelText: 'Número/Lote'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o número do lote' : null,
              ),
              TextFormField(
                controller: _complementoController,
                decoration: const InputDecoration(labelText: 'Complemento'),
              ),
              TextFormField(
                controller: _bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o bairro' : null,
              ),
              TextFormField(
                controller: _localidadeController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe a cidade' : null,
              ),
              TextFormField(
                controller: _ufController,
                decoration: const InputDecoration(labelText: 'UF'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o estado (UF)' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _salvarEndereco,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
