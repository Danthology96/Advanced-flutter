import 'package:chat_app/services/chat.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/users.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.username),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.username.substring(0, 2)),
        backgroundColor: Colors.blue[200],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.receiverUser = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
