import 'package:flutter/material.dart';
import 'package:minggu_3_whatsappui/data/call.dart';
import 'package:minggu_3_whatsappui/theme.dart';

class CallView extends StatelessWidget {
  const CallView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: callList.length,
      itemBuilder: (_, index) {
        final call = callList[index];
        return ListTile(
          leading: const Icon(
            Icons.account_circle, 
            color: Colors.black26,
            size: 58,
          ),
          title: Text(
            call.name,
            style: customTextStyle,
          ),
          subtitle: Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Colors.black45,
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                call.time,
                style: customTextStyle.copyWith(
                    color: Colors.black45,
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                ),
              ),
            ]
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(2),
            child: Icon(
              Icons.call,
              color: whatsAppLightGreen,
              size: 20,
            ),
          ),
          );
      },
    );
  }
}