import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/endereco_model.dart';

class EnderecoService {
  static final EnderecoService _instance = EnderecoService._internal();

  factory EnderecoService() {
    return _instance;
  }

  EnderecoService._internal();

  final List<Endereco> _enderecos = [];
  int _ultimoId = 0;

  Future<Endereco> getEnderecoByCep(String cep) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var endereco = Endereco.fromJson(data);
      endereco.cep = cep;
      return endereco;
    } else {
      throw Exception('Erro ao buscar endereço com CEP: $cep');
    }
  }

  Future<void> createEndereco(Endereco endereco) async {
    await Future.delayed(Duration(milliseconds: 500));
    _ultimoId++;
    endereco.id = _ultimoId;
    _enderecos.add(endereco);
  }

  Future<List<Endereco>> getEnderecos() async {
    await Future.delayed(Duration(milliseconds: 500));
    return _enderecos;
  }

  Future<void> updateEndereco(Endereco endereco) async {
    await Future.delayed(Duration(milliseconds: 500));
    int index = _enderecos.indexWhere((e) => e.id == endereco.id);
    if (index != -1) {
      _enderecos[index] = endereco;
    }
  }

  Future<void> deleteEndereco(int id) async {
    await Future.delayed(Duration(milliseconds: 500));
    _enderecos.removeWhere((e) => e.id == id);
  }
}