import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/user_controller.dart';
import 'package:getx/models/user.dart';

class Page2Page extends StatelessWidget {
  const Page2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// the way the controller is instanciated
    final userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              userController.loadUser(User(
                  name: 'Danto',
                  age: 25,
                  professions: ['Flutter dev', 'Gamer']));
              Get.snackbar('User established', 'Danto is the user name',
                  backgroundColor: Colors.white,
                  boxShadows: [
                    const BoxShadow(color: Colors.black38, blurRadius: 10),
                  ],
                  animationDuration: const Duration(milliseconds: 200));
            },
            color: Colors.blue,
            child: const Text(
              'Establish User',
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () {
              userController.changeAge(30);
            },
            color: Colors.blue,
            child: const Text(
              'Change age',
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () {
              userController.addProfession(
                  'Profession ${userController.user.value.professions!.length + 1}');
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
