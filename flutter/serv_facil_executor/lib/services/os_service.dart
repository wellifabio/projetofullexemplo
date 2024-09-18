import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serv_facil/constants.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/services/user_service.dart';

class OsService {
  static Future<List<Os>> getAllOs({required String token}) async {
    final response = await http.get(
      Uri.parse('$apiUrl/os'),
      headers: {
        'authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);

      for (Map data in body) {
        final User colaborador = await UserService.getColaborador(
            token: token, matricula: data['colaborador']);

        if (data['executor'] != null) {
          final User executor = await UserService.getColaborador(
              token: token, matricula: data['executor']);
          data.update('executor', (value) => executor);
        }
        data.update('colaborador', (value) => colaborador);
      }

      return body.map((e) => Os.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch closed Oss.');
    }
  }

  static Future<Os> getOs({
    required String token,
    required int osId,
  }) async {
    final response = await http.get(
      Uri.parse('$apiUrl/os/id/$osId'),
      headers: {
        'authorization': token,
        'content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;

      final User colaborador = await UserService.getColaborador(
        token: token,
        matricula: body['colaborador'],
      );
      User? executor;

      if (body['executor'] != null) {
        executor = await UserService.getColaborador(
          token: token,
          matricula: body['executor'],
        );
        body.update('executor', (value) => executor);
      }
      body.update('colaborador', (value) => colaborador);

      return Os.fromJson(body);
    } else {
      throw Exception('Could not fetch os.');
    }
  }

  static Future<List<Os>> getOpenOss({required String token}) async {
    final response = await http.get(
      Uri.parse('$apiUrl/os/abertas'),
      headers: {
        'authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);

      for (Map data in body) {
        final User colaborador = await UserService.getColaborador(
            token: token, matricula: data['colaborador']);

        if (data['executor'] != null) {
          final User executor = await UserService.getColaborador(
              token: token, matricula: data['executor']);
          data.update('executor', (value) => executor);
        }
        data.update('colaborador', (value) => colaborador);
      }

      return body.map((e) => Os.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch Oss.');
    }
  }

  static Future<List<Os>> getClosedOss({required String token}) async {
    final response = await http.get(
      Uri.parse('$apiUrl/os/fechadas'),
      headers: {
        'authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);

      for (Map data in body) {
        final User colaborador = await UserService.getColaborador(
            token: token, matricula: data['colaborador']);

        if (data['executor'] != null) {
          final User executor = await UserService.getColaborador(
              token: token, matricula: data['executor']);
          data.update('executor', (value) => executor);
        }
        data.update('colaborador', (value) => colaborador);
      }

      return body.map((e) => Os.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch closed Oss.');
    }
  }

  static Future<void> updateOs({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/os'),
      body: jsonEncode(data),
      headers: {
        'authorization': token,
        'content-type': 'application/json',
      },
    );

    if (response.statusCode != 202) {
      throw Exception('Could not update Os.');
    }
  }
}
