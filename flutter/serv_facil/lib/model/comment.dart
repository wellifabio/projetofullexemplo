import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';

class Comment {
  const Comment(
      {required this.id,
      required this.os,
      required this.colaborador,
      required this.date,
      required this.comentario});

  final int id;
  final Os os;
  final User colaborador;
  final DateTime date;
  final String comentario;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'os': Os os,
        'colaborador': User colaborador,
        'data': String data,
        'comentario': String comentario,
      } =>
        Comment(
          id: id,
          os: os,
          colaborador: colaborador,
          date: DateTime.parse(data),
          comentario: comentario,
        ),
      _ => throw const FormatException('Could not get comment.'),
    };
  }
}
