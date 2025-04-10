import '../models/endereco_model.dart';
import '../services/endereco_service.dart';

class EnderecoController {
  final EnderecoService _service = EnderecoService();

  Future<Endereco> buscarEnderecoPorCep(String cep) async {
    return await _service.getEnderecoByCep(cep);
  }

  Future<void> cadastrarEndereco(Endereco endereco) async {
    await _service.createEndereco(endereco);
  }

  Future<List<Endereco>> listarEnderecos() async {
    return await _service.getEnderecos();
  }

  Future<void> updateEndereco(Endereco endereco) async {
    await _service.updateEndereco(endereco);
  }

  Future<void> deleteEndereco(int id) async {
    await _service.deleteEndereco(id);
  }
}