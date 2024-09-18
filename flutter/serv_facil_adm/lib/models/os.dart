import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'user.dart';

class Os {
  const Os({
    required this.id,
    required this.descricao,
    required this.colaborador,
    required this.abertura,
    required this.executor,
    required this.encerramento,
    required this.local,
    required this.finished,
  });

  final int id;
  final String descricao;
  final User colaborador;
  final User? executor;
  final DateTime abertura;
  final DateTime? encerramento;
  final LatLng local;
  final bool finished;

  factory Os.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'descricao': String descricao,
        'colaborador': User colaborador,
        'executor': User? executor,
        'abertura': String abertura,
        'encerramento': String? encerramento,
        'latitude': double lat,
        'longitude': double lng,
      } =>
        Os(
          id: id,
          descricao: descricao,
          colaborador: colaborador,
          executor: executor,
          abertura: DateTime.parse(abertura),
          encerramento: encerramento == null ? null : DateTime.parse(encerramento),
          finished: encerramento == null ? false : true,
          local: LatLng(lat, lng),
        ),
      _ => throw const FormatException('Could not get Os.'),
    };
  }
}
