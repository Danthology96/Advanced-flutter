import 'package:chat_app/global/environments.dart';
import 'package:chat_app/models/messagesResponse.model.dart';
import 'package:chat_app/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/users.dart';

class ChatService with ChangeNotifier {
  late User receiverUser;

  Future<List<Message>> getChat(String userID) async {
    final resp = await http
        .get(Uri.parse('${Environment.apiUrl}/messages/$userID'), headers: {
      'Content-type': 'application/json',
      'x-token': await AuthService.getToken()
    });
    final messagesResponse = messagesResponseFromJson(resp.body);
    return messagesResponse.messages;
  }
}
