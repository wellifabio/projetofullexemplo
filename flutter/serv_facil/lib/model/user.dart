class User {
  const User({
    required this.token,
    required this.nome,
    required this.matricula,
    required this.cargo,
    required this.setor,
  });

  final String? token;
  final String nome;
  final String matricula;
  final String cargo;
  final String setor;

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'matricula': String matricula,
        'cargo': String cargo,
        'setor': String setor,
        'nome': String nome,
      } =>
        User(
          token: json['token'],
          nome: nome,
          matricula: matricula,
          cargo: cargo,
          setor: setor,
        ),
      _ => throw const FormatException('Could not get User.'),
    };
  }
}
