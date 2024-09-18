import 'dart:convert';

import 'package:serv_facil/constants.dart';
import 'package:serv_facil/model/user.dart';
import 'package:http/http.dart' as http;

class InvalidSetorException implements Exception {
  final String message;

  const InvalidSetorException(this.message);

  @override
  String toString() => message;
}

class UserService {
  static Future<User> login({
    required String matricula,
    required String pin,
  }) async {
    final data = <String, dynamic>{
      'matricula': matricula,
      'pin': pin,
    };

    final headers = <String, String>{
      'content-type': 'application/json',
    };

    final response = await http.post(Uri.parse('$apiUrl/login'),
        body: jsonEncode(data), headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if ((body['setor'] as String) != 'Manutenção') {
        throw const InvalidSetorException('setor is invalid');
      }
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Invalid matricula or PIN.');
    }
  }

  static Future<User> getColaborador({
    required String token,
    required String matricula,
  }) async {
    final response = await http.get(
      Uri.parse('$apiUrl/colaborador/$matricula'),
      headers: {
        'authorization': token,
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Could not get Colaborador.');
    }
  }

  static Future<void> addColaborador({
    required Map<String, dynamic> data,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/colaborador'),
      body: jsonEncode(data),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw Exception('Could not add Colaborador.');
    }
  }
}
