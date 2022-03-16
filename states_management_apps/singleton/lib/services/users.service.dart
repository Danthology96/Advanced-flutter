import 'dart:async';

import 'package:singleton/models/user.model.dart';

class _UserService {
  User? _user;

  final StreamController<User> _userStreamController =
      StreamController<User>.broadcast();

  User? get user => _user;

  bool get userExists => (_user != null) ? true : false;

  Stream<User> get userStream => _userStreamController.stream;

  void loadUser(User user) {
    _user = user;
    _userStreamController.add(user);
  }

  void changeAge(int value) {
    _user?.age = value;
    _userStreamController.add(_user!);
  }

  void dispose() {
    _userStreamController.close();
  }
}

final userService = _UserService();
