import 'dart:convert';

import 'package:serv_facil/constants.dart';
import 'package:serv_facil/models/os.dart';
import 'package:http/http.dart' as http;
import 'package:serv_facil/models/user.dart';
import 'package:serv_facil/services/user_service.dart';

class OsService {
  static Future<List<Os>> getOss({required String token}) async {
    final headers = <String, String>{
      'authorization': token,
      "content-type": "application/json",
    };
    final response = await http.get(Uri.parse('$apiUrl/os'), headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;

      for (Map<String, dynamic> os in body) {
        final User colaborador = await UserService.getUser(
          token: token,
          matricula: os['colaborador'],
        );
        User? executor;

        if (os['executor'] != null) {
          executor = await UserService.getUser(
            token: token,
            matricula: os['executor'],
          );
          os.update('executor', (value) => executor);
        }
        os.update('colaborador', (value) => colaborador);
      }

      return body.map((e) => Os.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch Oss.');
    }
  }

  static Future<Os> getOs({
    required String token,
    required int osId,
  }) async {
    final headers = <String, String>{
      'authorization': token,
      "content-type": "application/json",
    };
    final response =
        await http.get(Uri.parse('$apiUrl/os/id/$osId'), headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;

      final User colaborador = await UserService.getUser(
        token: token,
        matricula: body['colaborador'],
      );
      User? executor;

      if (body['executor'] != null) {
        executor = await UserService.getUser(
          token: token,
          matricula: body['executor'],
        );
        body.update('executor', (value) => executor);
      }
      body.update('colaborador', (value) => colaborador);

      return Os.fromJson(body);
    } else {
      throw Exception('Could not get Os.');
    }
  }

  static Future<void> addOs({
    required User colaborador,
    required String descricao,
  }) async {
    final data = <String, dynamic>{
      'descricao': descricao,
      'colaborador': colaborador.matricula,
    };

    final headers = <String, String>{
      'authorization': colaborador.token!,
      "content-type": "application/json",
    };

    final parsedData = jsonEncode(data);

    final response = await http.post(
      Uri.parse('$apiUrl/os'),
      body: parsedData,
      headers: headers,
    );

    if (response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception('Could not create new OS: ${body['message']}');
    }
  }

  static Future<void> updateOsDescription({
    required int id,
    required String descricao,
    required String token,
  }) async {
    final data = <String, dynamic>{
      'id': id,
      'descricao': descricao,
    };

    final headers = <String, String>{
      'authorization': token,
      "content-type": "application/json",
    };

    final response = await http.patch(
      Uri.parse('$apiUrl/os'),
      body: jsonEncode(data),
      headers: headers,
    );

    if (response.statusCode != 202) {
      final body = jsonDecode(response.body);
      throw Exception('Could not update OS: ${body['message']}');
    }
  }

  static Future<void> removeOs({ required int osId, required String token}) async {
    final headers = <String, String>{
      'authorization': token,
      "content-type": "application/json"
    };

    final response = await http.delete(Uri.parse('$apiUrl/os/$osId'), headers: headers);

    if (response.statusCode != 204) {
      throw Exception('Could not delete OS.');
    }
  }
}
