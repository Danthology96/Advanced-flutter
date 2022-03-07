import 'package:chat_app/widgets/chatInput.widget.dart';
import 'package:chat_app/widgets/chatMessage.widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessageWidget> _messages = [
    const ChatMessageWidget(
      text: 'Hola mundo',
      uid: '123',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leadingWidth: 40,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          title: Row(
            children: [
              CircleAvatar(
                child: const Text(
                  'Us',
                ),
                backgroundColor: Colors.blue[200],
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Usuario 1',
                style: TextStyle(color: Colors.black87),
              )
            ],
          )),

      /// SIEMPRE USAR UN CUSTOMSCROLLVIEW PARA OPTIMIZAR RECURSOS EN CASO DE
      /// USAR SHRINKWRAP TRUE
      body: Column(
        children: [
          Flexible(
            child: CustomScrollView(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _messages[index];
                    },
                    childCount: _messages.length,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            child: const ChatInputWidget(),
          ),
        ],
      ),
    );
  }
}
