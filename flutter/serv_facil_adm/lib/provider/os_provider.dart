import 'package:flutter/material.dart';
import 'package:serv_facil/models/os.dart';
import 'package:serv_facil/services/os_service.dart';

class OsProvider with ChangeNotifier {
  Future<List<Os>>? _oss;

  Future<void> fetchOss(String token) async {
    _oss = OsService.getOss(token: token);
    notifyListeners();
  }

  Future<List<Os>> get oss => _oss!;

  Future<void> addOs(String token, Os os) async {
    await OsService.addOs(colaborador: os.colaborador, descricao: os.descricao);
    await fetchOss(token);
  }

  Future<void> updateOs(String token, Os os) async {
    await OsService.updateOsDescription(id: os.id, descricao: os.descricao, token: token);
    await fetchOss(token);
  }
  
  Future<void> removeOs(String token, int osId) async {
    await OsService.removeOs(osId: osId, token: token);
    await fetchOss(token);
  }
}