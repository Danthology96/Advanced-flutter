import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/user_controller.dart';
import 'package:getx/pages/page2.dart';

import '../models/user.dart';

class Page1Page extends StatelessWidget {
  const Page1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Obx((() => userController.userExists.value
          ? UserInformation(
              user: userController.user.value,
            )
          : const NoInfo())),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => Navigator.pushNamed(context, 'page2'),
        onPressed: () => Get.to(() => const Page2Page()),
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}

class NoInfo extends StatelessWidget {
  const NoInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No user selected'),
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
            title: Text('Age: ${user.age}'),
          ),
          const Text(
            'Proffesions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ...user.professions
                  ?.map(
                    (e) => ListTile(
                      title: Text(e),
                    ),
                  )
                  .toList() ??
              []
        ],
      ),
    );
  }
}
