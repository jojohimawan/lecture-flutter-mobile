import 'package:flutter/material.dart';
import 'package:minggu_3_whatsappui/data/chat.dart';
import 'package:minggu_3_whatsappui/theme.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (_, index) {
        final chat = chatList[index];
        return ListTile(
          leading: Image.network(chat.image),
          title: Text(
            chat.name,
            style: customTextStyle,
          ),
          subtitle: Text(
            chat.mostRecentMessage,
            style: customTextStyle.copyWith(
              color: Colors.black45,
              fontSize: 16,
              fontWeight: FontWeight.normal
            ),
          ),
          trailing: Padding(
            padding:  const EdgeInsets.only(bottom: 25),
            child: Text(
              chat.messageDate,
              style: customTextStyle.copyWith(
                color: Colors.black45,
                fontSize: 12
              ),
            ),
          ),
        );
      },
    );
  }
}