import '../models/usuario_model.dart';
import '../services/usuario_service.dart';
import '../utils/hash_util.dart';

class UsuarioController {
  final UsuarioService _service = UsuarioService();

  Future<List<Usuario>> listarUsuarios() async {
    return await _service.getUsuarios();
  }

  Future<void> cadastrarUsuario(String login, String senha) async {
    final senhaHash = HashUtil.generate(senha);
    final novoUsuario = Usuario(login: login, senha: senhaHash);
    await _service.createUsuario(novoUsuario);
  }

  Future<Usuario?> authenticate(String login, String senha) async {
    return await _service.authenticate(login, senha);
  }
}
