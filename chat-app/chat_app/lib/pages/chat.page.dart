import 'dart:async';
import 'dart:io';

import 'package:chat_app/models/messagesResponse.model.dart';
import 'package:chat_app/widgets/chatMessage.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.service.dart';
import '../services/chat.service.dart';
import '../services/socket.service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  final List<ChatMessageWidget> _messages = [];

  bool _isTyping = false;

  @override
  void initState() {
    super.initState();

    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('personal-message', _listenMessage);

    _cargarHistorial(chatService.receiverUser.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Message> chat = await chatService.getChat(usuarioID);
    final history = chat.map((message) => ChatMessageWidget(
        text: message.message,
        uid: message.from,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload) {
    if (payload['from'] != chatService.receiverUser.uid &&
        payload['from'] != authService.user!.uid) {
      return;
    }
    ChatMessageWidget message = ChatMessageWidget(
      text: payload['message'],
      uid: payload['from'],
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController!
        .forward()
        .then((value) => Timer(const Duration(milliseconds: 500), () {
              message.animationController!.dispose();
            }));
  }

  @override
  Widget build(BuildContext context) {
    final receiverUser = chatService.receiverUser;

    return Scaffold(
      appBar: AppBar(
          // leadingWidth: 40,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
              )),
          title: Row(
            children: [
              CircleAvatar(
                child: Text(
                  receiverUser.username.substring(0, 2),
                ),
                backgroundColor: Colors.blue[200],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                receiverUser.username,
                style: const TextStyle(color: Colors.black87),
              )
            ],
          )),
      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _messages.length,
            itemBuilder: (_, i) => _messages[i],
            reverse: true,
          )),
          const Divider(height: 1),
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (texto) {
              setState(() {
                if (texto.trim().isNotEmpty) {
                  _isTyping = true;
                } else {
                  _isTyping = false;
                }
              });
            },
            decoration:
                const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
          )),

          // Botón de enviar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessageWidget(
      uid: authService.user!.uid,
      text: texto,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController!
        .forward()
        .then((value) => Timer(const Duration(milliseconds: 500), () {
              newMessage.animationController!.dispose();
            }));

    setState(() {
      _isTyping = false;
    });

    socketService.emit('personal-message', {
      'from': authService.user!.uid,
      'to': chatService.receiverUser.uid,
      'message': texto
    });
  }

  @override
  void dispose() {
    socketService.socket.off('personal-message');
    super.dispose();
  }
}
