import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/showAlert.helper.dart';
import '../services/auth.service.dart';
import '../services/socket.service.dart';
import '../widgets/customInputField.widget.dart';
import '../widgets/labels.widget.dart';
import '../widgets/loginButton.widget.dart';
import '../widgets/logo.widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                Logo(
                  text: 'Register',
                ),
                _Form(),
                SizedBox(
                  height: 20,
                ),
                Labels(
                  route: 'login',
                  text: '¿Ya tienes una cuenta?',
                  linkText: 'Iniciar sesión',
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
              icon: Icons.perm_identity_outlined,
              hintText: 'Name',
              textController: nameController,
              textInputType: TextInputType.name),
          const SizedBox(
            height: 20,
          ),
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
          CustomInputField(
            icon: Icons.lock_outline,
            hintText: 'Confirm password',
            textController: confirmPasswordController,
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
                    /// para comprobar que todos los campos estén completos
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      showAlert(
                          context: context,
                          title: 'Campos incompletos',
                          subtitle: 'Ingrese todos los campos');
                      return;
                    }

                    /// para comprobar la contraseña
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      showAlert(
                          context: context,
                          title: 'Contraseñas no coinciden',
                          subtitle: 'Las contraseñas no coinciden');
                      return;
                    }

                    /// quita el foco de lo que sea, en este caso ayuda a quitar
                    /// el teclado al dar el botón de ingresar
                    FocusScope.of(context).unfocus();
                    final registered = await authService.register(
                      nameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );

                    if (registered == true) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(
                          context: context,
                          title: 'Registro incompleto',
                          subtitle: registered);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
