class User {
  const User({
    required this.matricula,
    required this.nome,
    required this.cargo,
    required this.setor,
    required this.token,
    required this.oss,
  });

  final String matricula;
  final String nome;
  final String cargo;
  final String setor;
  final String? token;
  final List oss;

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'matricula': String matricula,
        'nome': String nome,
        'cargo': String cargo,
        'setor': String setor,
        'oss': List oss,
      } =>
        User(
          matricula: matricula,
          nome: nome,
          cargo: cargo,
          setor: setor,
          token: json['token']?? json['token'],
          oss: oss,
        ),
      _ => throw const FormatException('Could not get User.'),
    };
  }
}
