import 'package:cubit/bloc/user/user.cubit.dart';
import 'package:cubit/pages/page1.dart';
import 'package:cubit/pages/page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => UserCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cubit App',
        initialRoute: 'page1',
        routes: {
          'page1': (_) => const Page1Page(),
          'page2': (_) => const Page2Page(),
        },
      ),
    );
  }
}
