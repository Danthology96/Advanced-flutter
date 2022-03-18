import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/pages/page1.dart';
import 'package:provider_app/pages/page2.dart';
import 'package:provider_app/services/user.service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// use MultiProvider to use more than one provider
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Singleton App',
        initialRoute: 'page1',
        routes: {
          'page1': (_) => const Page1Page(),
          'page2': (_) => const Page2Page(),
        },
      ),
    );
  }
}
