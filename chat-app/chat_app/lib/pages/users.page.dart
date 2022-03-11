import 'package:chat_app/models/users.dart';
import 'package:chat_app/services/auth.service.dart';
import 'package:chat_app/services/socket.service.dart';
import 'package:chat_app/services/users.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widgets/usersListview.widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersService = UsersService();

  List<User> users = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user!.username,
          style: const TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              socketService.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
            icon: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.black87,
            )),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: (socketService.serverStatus == ServerStatus.online)
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[400],
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red[400],
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
    users = await usersService.getUsers();
    setState(() {});
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
