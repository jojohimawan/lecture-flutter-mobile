import 'package:flutter/material.dart';
import 'package:minggu_7/data/chat.dart';
import 'package:minggu_7/theme/theme.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildChatContainer(),
          _buildChatsListTile()
        ],
      ),
    );
  }

  Widget _buildChatContainer() {
    return ListTile(
      leading: Icon(
        Icons.archive,
        color: whatsappSecondary,
      ),
      title: const Text('Arsip'),
      trailing: Text(
        '2',
        style: TextStyle(
          fontSize: 12,
          color: whatsappSecondary
        ),
      ),
    );
  }

  Widget _buildChatsListTile() {
    return Column(
      children: List.generate(chatList.length, (index) {
        return ListTile(
          leading: Image.network(chatList[index].image),
          title: Text(
            chatList[index].name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
          ),
          subtitle: Text(
            chatList[index].mostRecentMessage,
          ),
          trailing: Padding(
            padding:  const EdgeInsets.only(bottom: 25),
            child: Text(
              chatList[index].messageDate,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),
        );
      }),
    ); 
  }
}