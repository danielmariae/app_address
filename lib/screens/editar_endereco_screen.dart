import 'package:flutter/material.dart';
import '../../models/endereco_model.dart';
import '../../services/endereco_service.dart';

class EditarEnderecoScreen extends StatefulWidget {
  final Endereco endereco;
  final VoidCallback onEdit;

  const EditarEnderecoScreen({
    super.key,
    required this.endereco,
    required this.onEdit,
  });

  @override
  State<EditarEnderecoScreen> createState() => _EditarEnderecoScreenState();
}

class _EditarEnderecoScreenState extends State<EditarEnderecoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _localidadeController = TextEditingController();
  final _ufController = TextEditingController();

  final _service = EnderecoService();

  @override
  void initState() {
    super.initState();
    final e = widget.endereco;
    _cepController.text = e.cep ?? '';
    _logradouroController.text = e.logradouro;
    _numeroController.text = e.numeroLote;
    _complementoController.text = e.complemento;
    _bairroController.text = e.bairro;
    _localidadeController.text = e.localidade;
    _ufController.text = e.uf;
  }

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

  void _salvarAlteracoes() async {
    if (_formKey.currentState!.validate()) {
      final enderecoAtualizado = Endereco(
        id: widget.endereco.id,
        cep: _cepController.text,
        logradouro: _logradouroController.text,
        numeroLote: _numeroController.text,
        complemento: _complementoController.text,
        bairro: _bairroController.text,
        localidade: _localidadeController.text,
        uf: _ufController.text,
      );
      await _service.updateEndereco(enderecoAtualizado);
      widget.onEdit();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Endereço')),
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
                onPressed: _salvarAlteracoes,
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
