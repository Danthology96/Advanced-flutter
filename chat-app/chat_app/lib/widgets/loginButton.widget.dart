import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          primary: const Color(0xff4482EF),
          shape: const StadiumBorder(),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          )),
        ));
  }
}
