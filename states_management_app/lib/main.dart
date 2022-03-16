import 'package:flutter/material.dart';
import 'package:states_management_app/pages/page1.dart';
import 'package:states_management_app/pages/page2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'States App',
      initialRoute: 'page1',
      routes: {
        'page1': (_) => const Page1Page(),
        'page2': (_) => const Page2Page(),
      },
    );
  }
}
