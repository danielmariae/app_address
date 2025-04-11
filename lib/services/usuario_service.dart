import 'dart:convert';
import 'package:app_address/utils/hash_util.dart';
import 'package:http/http.dart' as http;
import '../models/usuario_model.dart';

class UsuarioService {
  static const String baseUrl = 'https://67f9066e094de2fe6ea02a60.mockapi.io/usuario';

  Future<List<Usuario>> getUsuarios() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Usuario.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar usuários');
    }
  }

  Future<void> addUsuario(Usuario usuario) async {
    final usuarios = await getUsuarios();

    // Verificação se o login já foi usado
    final loginExiste = usuarios.any((u) => u.login == usuario.login);
    if (loginExiste) {
      throw Exception('Login já está em uso');
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao criar usuário');
    }
  }


  Future<Usuario?> authenticate(String login, String senha) async {
    final usuarios = await getUsuarios();
    final senhaHash = HashUtil.generate(senha);
    try {
      return usuarios.firstWhere(
        (u) => u.login == login && u.senha == senhaHash,
      );
    } catch (_) {
      return null;
    }
  }
}
