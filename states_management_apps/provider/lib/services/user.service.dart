import 'package:flutter/material.dart';
import 'package:provider_app/models/user.dart';

class UserService with ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get userExists => _user != null ? true : false;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  void changeAge(int value) {
    _user?.age = value;
    notifyListeners();
  }

  void deleteUser() {
    _user = null;
    notifyListeners();
  }

  void addProfession() {
    _user?.proffesions?.add('Profesion ${_user!.proffesions!.length + 1}');
    notifyListeners();
  }
}
