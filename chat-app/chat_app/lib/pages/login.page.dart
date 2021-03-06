import 'package:chat_app/services/socket.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/helpers/showAlert.helper.dart';
import 'package:chat_app/services/auth.service.dart';

import '../widgets/customInputField.widget.dart';
import '../widgets/labels.widget.dart';
import '../widgets/loginButton.widget.dart';
import '../widgets/logo.widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Logo(text: 'Messenger'),
                _Form(),
                SizedBox(
                  height: 20,
                ),
                Labels(
                  route: 'register',
                  text: '¿No tienes una cuenta?',
                  linkText: 'Crea una cuenta',
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInputField(
              icon: Icons.email_outlined,
              hintText: 'Email',
              textController: emailController,
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 20,
          ),
          CustomInputField(
            icon: Icons.lock_outline,
            hintText: 'Password',
            textController: passwordController,
            textInputType: TextInputType.visiblePassword,
            isPassword: true,
          ),
          const SizedBox(
            height: 20,
          ),
          LoginButtonWidget(
              text: 'Ingresar',
              onPressed: authService.autenticating
                  ? null
                  : () async {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showAlert(
                            context: context,
                            title: 'Credenciales inválidas',
                            subtitle: 'Ingrese todos los campos');
                        return;
                      }

                      /// quita el foco de lo que sea, en este caso ayuda a quitar
                      /// el teclado al dar el botón de ingresar
                      FocusScope.of(context).unfocus();
                      final logged = await authService.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (logged) {
                        socketService.connect();
                        Navigator.pushReplacementNamed(context, 'users');
                      } else {
                        showAlert(
                            context: context,
                            title: 'Credenciales inválidas',
                            subtitle: 'Intente nuevamente');
                      }
                    }),
        ],
      ),
    );
  }
}
