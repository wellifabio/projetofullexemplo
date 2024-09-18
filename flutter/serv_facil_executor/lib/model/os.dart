import 'package:serv_facil/model/user.dart';

class Os {
  const Os({
    required this.id,
    required this.descricao,
    required this.colaborador,
    required this.executor,
    required this.abertura,
    required this.encerramento,
    required this.latitude,
    required this.longitude,
  });

  final int id;
  final String descricao;
  final User colaborador;
  final User? executor;
  final DateTime abertura;
  final DateTime? encerramento;
  final double latitude;
  final double longitude;

  factory Os.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'descricao': String descricao,
        'colaborador': User colaborador,
        'executor': User? executor,
        'abertura': String abertura,
        'encerramento': String? encerramento,
        'latitude': double latitude,
        'longitude': double longitude,
      } =>
        Os(
          id: id,
          descricao: descricao,
          colaborador: colaborador,
          executor: executor,
          abertura: DateTime.parse(abertura),
          encerramento: encerramento != null ? DateTime.parse(encerramento) : null,
          latitude: latitude,
          longitude: longitude,
        ),
      _ => throw const FormatException('Could not get Os.'),
    };
  }
}
