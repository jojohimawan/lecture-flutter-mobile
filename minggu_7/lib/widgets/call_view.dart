import 'package:flutter/material.dart';
import 'package:minggu_7/data/call.dart';
import 'package:minggu_7/theme/theme.dart';


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
              ),
            ]
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(2),
            child: Icon(
              Icons.call,
              color: whatsappPrimary,
              size: 20,
            ),
          ),
          );
      },
    );
  }
}