import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {Key? key,
      required this.text,
      required this.uid,
      this.animationController})
      : super(key: key);

  final String text;
  final String uid;
  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    bool _ownMessage = false;

    if (uid == '123') {
      _ownMessage = true;
    }

    ///TODO: Agregar esta animación una vez ya se tenga el backend
    // return FadeTransition(
    //   opacity: animationController!,
    //  child: SizeTransition(sizeFactor: CurvedAnimation(parent: animationController!, curve: Curves.easeOut),)
    return Align(
      alignment: _ownMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: _ownMessage
            ? const EdgeInsets.only(bottom: 5, left: 50, right: 10)
            : const EdgeInsets.only(bottom: 5, right: 50, left: 10),
        child: Text(
          text,
          style: _ownMessage
              ? const TextStyle(color: Colors.white)
              : const TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
          color: _ownMessage ? Colors.blue[400] : const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
