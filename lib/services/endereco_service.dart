import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/endereco_model.dart';

class EnderecoService {
  static const String baseUrl = 'https://67f9066e094de2fe6ea02a60.mockapi.io/endereco';

  Future<List<Endereco>> getEnderecos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Endereco.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar endereços');
    }
  }

  Future<Endereco?> getEnderecoByCep(String cep) async {
  final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data.containsKey('erro')) return null;

    return Endereco(
      // id: , // Será gerado pela API do mockapi
      cep: data['cep'] ?? '',
      logradouro: data['logradouro'] ?? '',
      bairro: data['bairro'] ?? '',
      uf: data['uf'] ?? '',
      localidade: data['localidade'] ?? '',
      numeroLote: '', // preenchido manualmente pelo usuário
      complemento: '', // preenchido manualmente pelo usuário
    );
  } else {
    return null;
  }
}

  Future<void> addEndereco(Endereco endereco) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(endereco.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao criar endereço');
    }
  }

  Future<void> updateEndereco(Endereco endereco) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${endereco.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(endereco.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar endereço');
    }
  }

  Future<void> deleteEndereco(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar endereço');
    }
  }
}