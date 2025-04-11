import 'package:flutter/material.dart';
import '../models/endereco_model.dart';

class EnderecoCard extends StatelessWidget {
  final Endereco endereco;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EnderecoCard({
    super.key,
    required this.endereco,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text('${endereco.logradouro}, ${endereco.numeroLote}'),
        subtitle: Text('${endereco.bairro} - ${endereco.localidade}/${endereco.uf}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}