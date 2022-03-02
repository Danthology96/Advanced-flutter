import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.textController,
    required this.textInputType,
    this.isPassword,
  }) : super(key: key);

  final IconData icon;
  final String hintText;
  final TextEditingController textController;
  final TextInputType textInputType;
  final bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5),
        ],
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        obscureText: isPassword ?? false,
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
