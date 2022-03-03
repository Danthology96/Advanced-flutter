import 'package:chat_app/widgets/userListTile.widget.dart';
import 'package:flutter/material.dart';

import '../models/users.dart';

class UsersListview extends StatelessWidget {
  const UsersListview({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => UserListTile(user: users[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: users.length);
  }
}
