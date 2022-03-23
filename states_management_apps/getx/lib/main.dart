import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/pages/page1.dart';
import 'package:getx/pages/page2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Getx App',
      initialRoute: 'page1',
      // routes: {
      //   'page1': (_) => const Page1Page(),
      //   'page2': (_) => const Page2Page(),
      // },
      getPages: [
        GetPage(name: '/page1', page: () => const Page1Page()),
        GetPage(name: '/page2', page: () => const Page2Page()),
      ],
    );
  }
}
