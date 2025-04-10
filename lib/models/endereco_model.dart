class Endereco {
  int? id;
  String? cep; // Para busca na API ViaCEP
  String logradouro;
  String numeroLote;
  String complemento;
  String bairro;
  String uf;
  String localidade;

  Endereco({
    this.id,
    this.cep,
    required this.logradouro,
    required this.numeroLote,
    required this.complemento,
    required this.bairro,
    required this.uf,
    required this.localidade,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'],
      logradouro: json['logradouro'],
      numeroLote: "", // Informado pelo usuário
      complemento: json['complemento'] ?? "",
      bairro: json['bairro'],
      uf: json['uf'],
      localidade: json['localidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cep': cep,
      'logradouro': logradouro,
      'numeroLote': numeroLote,
      'complemento': complemento,
      'bairro': bairro,
      'uf': uf,
      'localidade': localidade,
    };
  }
}
