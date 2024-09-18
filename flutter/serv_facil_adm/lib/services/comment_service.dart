import 'dart:convert';

import 'package:serv_facil/constants.dart';
import 'package:serv_facil/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:serv_facil/models/os.dart';
import 'package:serv_facil/models/user.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/services/user_service.dart';

class CommentService {
  static Future<List<Comment>> getComments({
    required int osId,
    required String token,
  }) async {
    final headers = <String, String>{
      'authorization': token,
      "content-type": "application/json",
    };
    final response =
        await http.get(Uri.parse('$apiUrl/comentario/$osId'), headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body)[0] as Map<String, dynamic>;
      final List comentarios = body['comentarios'];

      for (Map comment in comentarios) {
        final User colaborador = await UserService.getUser(
            token: token, matricula: comment['colaborador']);
        final Os os = await OsService.getOs(token: token, osId: osId);

        comment.update('colaborador', (value) => colaborador);
        comment.update('os', (value) => os);
      }

      return comentarios.map((e) => Comment.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch comments.');
    }
  }

  static Future<void> addComment({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    final headers = <String, String>{
      'authorization': token,
      "content-type": "application/json"
    };

    final response = await http.post(
      Uri.parse('$apiUrl/comentario'),
      body: jsonEncode(data),
      headers: headers,
    );

    if (response.statusCode != 201) {
      throw const FormatException('Could not create Comment.');
    }
  }
}
