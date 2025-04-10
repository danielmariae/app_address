import 'package:flutter/material.dart';
import '../controllers/endereco_controller.dart';
import '../models/endereco_model.dart';

class EditarEnderecoView extends StatefulWidget {
  final Endereco endereco;
  final VoidCallback onEdit;

  const EditarEnderecoView({super.key, required this.endereco, required this.onEdit});

  @override
  _EditarEnderecoViewState createState() => _EditarEnderecoViewState();
}

class _EditarEnderecoViewState extends State<EditarEnderecoView> {
  final _numeroLoteController = TextEditingController();
  final _complementoController = TextEditingController();
  late Endereco _enderecoEdit;
  final EnderecoController _controller = EnderecoController();

  @override
  void initState() {
    super.initState();
    _enderecoEdit = widget.endereco;
    _numeroLoteController.text = _enderecoEdit.numeroLote;
    _complementoController.text = _enderecoEdit.complemento;
  }

  void _salvarEdicao() async {
    _enderecoEdit.numeroLote = _numeroLoteController.text;
    _enderecoEdit.complemento = _complementoController.text;
    await _controller.updateEndereco(_enderecoEdit);
    widget.onEdit();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Endereço')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('CEP: ${_enderecoEdit.cep}'),
            Text('Logradouro: ${_enderecoEdit.logradouro}'),
            Text('Bairro: ${_enderecoEdit.bairro}'),
            Text('Localidade: ${_enderecoEdit.localidade}'),
            Text('UF: ${_enderecoEdit.uf}'),
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
              child: Text('Salvar Alterações'),
              onPressed: _salvarEdicao,
            )
          ],
        ),
      ),
    );
  }
}
