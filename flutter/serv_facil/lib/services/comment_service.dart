import 'dart:convert';

import 'package:serv_facil/constants.dart';
import 'package:serv_facil/model/comment.dart';
import 'package:http/http.dart' as http;
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/services/user_service.dart';

class CommentService {
  static Future<List<Comment>> getComments({
    required String token,
    required int osId,
  }) async {
    final response = await http.get(
      Uri.parse('$apiUrl/comentario/$osId'),
      headers: {
        'authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final List comments =
          (jsonDecode(response.body)[0] as Map<String, dynamic>)['comentarios'];

      for (Map comment in comments) {
        final Os os = await OsService.getOs(token: token, osId: osId);
        final User colaborador = await UserService.getColaborador(
            token: token, matricula: comment['colaborador']);

        comment.update('os', (value) => os);
        comment.update('colaborador', (value) => colaborador);
      }

      return comments.map((e) => Comment.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch comments.');
    }
  }

  static Future<void> addComment({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/comentario'),
      body: jsonEncode(data),
      headers: {
        'authorization': token,
        'content-type': 'application/json',
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Could not add comment.');
    }
  }
}
