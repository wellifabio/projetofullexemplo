import 'package:flutter/material.dart';
import 'package:serv_facil/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get user => _user!;

  set user(User user) {
    _user = user;
    notifyListeners();
  }
}
