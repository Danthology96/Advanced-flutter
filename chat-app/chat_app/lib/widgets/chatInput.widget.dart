import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'chatMessage.widget.dart';

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget>
    with TickerProviderStateMixin {
  final _focusNode = FocusNode();

  final _textController = TextEditingController();

  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Row(children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String text) {
                setState(() {
                  if (text.trim().isNotEmpty) {
                    _isTyping = true;
                  } else {
                    _isTyping = false;
                  }
                });
              },
              decoration:
                  const InputDecoration.collapsed(hintText: 'Escribir mensaje'),
              focusNode: _focusNode,
            ),
          ),
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 4),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: const Text('Send'),
                    onPressed: _isTyping
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: _isTyping
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                          icon: const Icon(
                            Icons.send,
                          )),
                    ),
                  ),
          ),
        ]),
      ),
    );
  }

  _handleSubmit(
    String text,
  ) {
    if (text.isEmpty) return;

    _focusNode.requestFocus();
    _textController.clear();

    ///TODO: Poner la lógica de enviar mensajes aquí
    // final newMessage = new ChatMessageWidget(
    //   text: text,
    //   uid: '123',
    //   animationController: AnimationController(
    //     vsync: this,
    //     duration: Duration(seconds: 0.4),
    //   ),
    // );
    // newMessage.animationController?.forward();
    setState(() {
      _isTyping = false;
      // Timer(Duration(seconds: 0.5), newMessage.animationController?.dispose());
      // newMessage.animationController?.dispose();
    });
  }

  /// para limpiar de los controllers
  @override
  void dispose() {
    ///TODO: Off del socket

    super.dispose();
  }
}
