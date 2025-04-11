import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/endereco_model.dart';

class EnderecoService with ChangeNotifier {
  static const String baseUrl = 'https://67f9066e094de2fe6ea02a60.mockapi.io/endereco';

  final List<Endereco> _enderecos = [];

  List<Endereco> get enderecos => List.unmodifiable(_enderecos);

  Future<void> carregarEnderecos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _enderecos
        ..clear()
        ..addAll(data.map((e) => Endereco.fromJson(e)));
      notifyListeners();
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
        cep: data['cep'] ?? '',
        logradouro: data['logradouro'] ?? '',
        bairro: data['bairro'] ?? '',
        uf: data['uf'] ?? '',
        localidade: data['localidade'] ?? '',
        numeroLote: '',
        complemento: '',
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
    if (response.statusCode == 201) {
      final novo = Endereco.fromJson(json.decode(response.body));
      _enderecos.add(novo);
      notifyListeners();
    } else {
      throw Exception('Erro ao criar endereço');
    }
  }

  Future<void> updateEndereco(Endereco endereco) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${endereco.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(endereco.toJson()),
    );
    if (response.statusCode == 200) {
      final index = _enderecos.indexWhere((e) => e.id == endereco.id);
      if (index != -1) {
        _enderecos[index] = endereco;
        notifyListeners();
      }
    } else {
      throw Exception('Erro ao atualizar endereço');
    }
  }

  Future<void> deleteEndereco(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      _enderecos.removeWhere((e) => e.id == id);
      notifyListeners();
    } else {
      throw Exception('Erro ao deletar endereço');
    }
  }
}