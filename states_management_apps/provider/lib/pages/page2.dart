import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/models/user.dart';
import 'package:provider_app/services/user.service.dart';

class Page2Page extends StatelessWidget {
  const Page2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(userService.user?.name ?? 'Page 2'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              userService.user = User(
                  name: 'Danto',
                  age: 25,
                  proffesions: ['Flutter developer', 'Profesional gamer']);
            },
            color: Colors.blue,
            child: const Text(
              'Establish User',
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () {
              userService.changeAge(26);
            },
            color: Colors.blue,
            child: const Text(
              'Change age',
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () {
              userService.addProfession();
            },
            color: Colors.blue,
            child: const Text(
              'Add proffesion',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      )),
    );
  }
}
