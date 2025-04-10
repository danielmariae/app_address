import 'dart:async';
import '../models/usuario_model.dart';
import '../utils/hash_util.dart';

class UsuarioService {
  static final UsuarioService _instance = UsuarioService._internal();

  factory UsuarioService() {
    return _instance;
  }

  UsuarioService._internal();

  final List<Usuario> _usuarios = [];
  int _ultimoId = 0;

  Future<List<Usuario>> getUsuarios() async {
    await Future.delayed(Duration(milliseconds: 500));
    return _usuarios;
  }

  Future<void> createUsuario(Usuario usuario) async {
    await Future.delayed(Duration(milliseconds: 500));
    _ultimoId++;
    usuario.id = _ultimoId;
    _usuarios.add(usuario);
  }

  Future<Usuario?> authenticate(String login, String senha) async {
    await Future.delayed(Duration(milliseconds: 500));
    final senhaHash = HashUtil.generate(senha);
    try {
      return _usuarios.firstWhere(
        (usuario) => usuario.login == login && usuario.senha == senhaHash);
    } catch (e) {
      return null;
    }
  }
}
