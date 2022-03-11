import 'package:chat_app/global/environments.dart';
import 'package:chat_app/models/usersResponse.model.dart';
import 'package:chat_app/services/auth.service.dart';
import 'package:http/http.dart' as http;
import '../models/users.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/users'),
          headers: {
            'content-type': 'application/json',
            'x-token': await AuthService.getToken()
          });

      final usersResponse = usersResponseFromJson(resp.body);
      return usersResponse.users;
    } catch (e) {
      return [];
    }
  }
}
