import 'package:chat_app/models/users.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widgets/userListTile.widget.dart';
import '../widgets/usersListview.widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    User(online: true, email: 'test1@test.com', name: 'User 1', uid: '1'),
    User(online: true, email: 'test2@test.com', name: 'User 2', uid: '2'),
    User(online: false, email: 'test3@test.com', name: 'User 3', uid: '3'),
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User name',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.black87,
            )),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue[400]!,
        ),
        child: UsersListview(users: users),
      ),
    );
  }

  void _loadUsers() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
