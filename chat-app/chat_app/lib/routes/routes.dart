import 'package:flutter/material.dart';

import 'package:chat_app/pages/chat.page.dart';
import 'package:chat_app/pages/loading.page.dart';
import 'package:chat_app/pages/login.page.dart';
import 'package:chat_app/pages/register.page.dart';
import 'package:chat_app/pages/users.page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users': (_) => const UsersPage(),
  'chat': (_) => const ChatPage(),
  'register': (_) => const RegisterPage(),
  'login': (_) => const LoginPage(),
  'loading': (_) => const LoadingPage(),
};
