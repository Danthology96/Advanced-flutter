import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.service.dart';

class ChatMessageWidget extends StatefulWidget {
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
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  late AuthService authService;

  @override
  void initState() {
    super.initState();

    authService = Provider.of<AuthService>(context, listen: false);

    /// al mover la lógica a otro archivo, se crea una animación por mensaje,
    /// una posible solución es mover este código al chatPage y otra es
    /// usar un timer para que luego de la animación del mensaje eliminar
    /// el controller de la animación
    // Timer(const Duration(milliseconds: 500), () {
    //   widget.animationController?.dispose();
    //   print('animación borrada');
    // });
  }

  @override
  Widget build(BuildContext context) {
    bool _ownMessage = false;

    if (widget.uid == authService.user!.uid) {
      _ownMessage = true;
    }

    return FadeTransition(
      opacity: widget.animationController!,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: widget.animationController!, curve: Curves.easeOut),
        child: Align(
          alignment: _ownMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: _ownMessage
                ? const EdgeInsets.only(bottom: 5, left: 50, right: 10)
                : const EdgeInsets.only(bottom: 5, right: 50, left: 10),
            child: Text(
              widget.text,
              style: _ownMessage
                  ? const TextStyle(color: Colors.white)
                  : const TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
              color: _ownMessage ? Colors.blue[400] : const Color(0xffE4E5E8),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
