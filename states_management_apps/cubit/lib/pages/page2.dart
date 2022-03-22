import 'package:cubit/bloc/user/user.cubit.dart';
import 'package:cubit/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Page2Page extends StatelessWidget {
  const Page2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
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
              final user = User(
                  name: 'Danto',
                  age: 25,
                  proffesions: ['Flutter Developer', 'Gamer']);
              userCubit.selectUser(user);
            },
            color: Colors.blue,
            child: const Text(
              'Establish User',
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () {
              userCubit.changeAge(30);
            },
            color: Colors.blue,
            child: const Text(
              'Change age',
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () {
              userCubit.addProffesion();
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
