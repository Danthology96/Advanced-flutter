import 'dart:convert';

import 'package:chat_app/global/environments.dart';
import 'package:chat_app/models/loginResponse.model.dart';
import 'package:chat_app/models/registerResponse.model.dart';
import 'package:chat_app/models/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  User? user;
  String? token;
  bool _autenticating = false;

  // Create storage
  final _storage = const FlutterSecureStorage();

  bool get autenticating => _autenticating;

  set autenticating(bool value) {
    _autenticating = value;
    notifyListeners();
  }

  /// Getter del token de forma estática
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  /// Getter del token de forma estática
  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticating = true;

    final data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});

    autenticating = false;
    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.user;

      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String username, String email, String password) async {
    autenticating = true;
    final data = {
      'username': username,
      'email': email,
      'password': password,
    };
    final response = await http.post(
        Uri.parse('${Environment.apiUrl}/login/new'),
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});

    autenticating = false;

    if (response.statusCode == 200) {
      final registerResponse = registerResponseFromJson(response.body);
      user = registerResponse.user;

      await _saveToken(registerResponse.token);
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final response = await http.get(
        Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'x-token': '$token', 'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      final registerResponse = registerResponseFromJson(response.body);
      user = registerResponse.user;
      await _saveToken(registerResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    // Write value in secure storage
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value in secure storage
    await _storage.delete(key: 'token');
  }
}
