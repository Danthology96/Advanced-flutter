import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/services/user.service.dart';

import '../models/user.dart';

class Page1Page extends StatelessWidget {
  const Page1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => userService.deleteUser())
        ],
      ),
      body: userService.userExists
          ? UserInformation(user: userService.user!)
          : const Center(child: Text('No user selected')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'page2'),
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'General',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ListTile(
            title: Text('Name: ${user.name}'),
          ),
          ListTile(
            title: Text('Age:  ${user.age}'),
          ),
          const Text(
            'Proffesions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ...?user.proffesions?.map((e) => ListTile(title: Text(e))).toList(),
          // const ListTile(
          //   title: Text('profesion1'),
          // ),
        ],
      ),
    );
  }
}
