class Usuario {
  int? id;
  String login;
  String senha; // Armazena o hash da senha

  Usuario({this.id, required this.login, required this.senha});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      login: json['login'],
      senha: json['senha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'senha': senha,
    };
  }
}