import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({Key? key, required this.route, this.text, this.linkText})
      : super(key: key);

  final String route;
  final String? text;
  final String? linkText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text ?? '',
          style: const TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, route),
          onLongPress: () {},
          child: Text(
            linkText ?? '',
            style: const TextStyle(
                color: Color(0xff4482EF),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
