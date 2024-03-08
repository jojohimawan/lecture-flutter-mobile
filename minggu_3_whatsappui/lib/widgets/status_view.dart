import 'package:flutter/material.dart';
import 'package:minggu_3_whatsappui/data/status.dart';
import 'package:minggu_3_whatsappui/theme.dart';

class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: statusList.length,
      itemBuilder: (_, index) {
        final status = statusList[index];
        return ListTile(
          leading: const Icon(
            Icons.account_circle, 
            color: Colors.black26,
            size: 58,
          ),
          title: Text(
            status.name,
            style: customTextStyle,
          ),
          subtitle: Text(
            status.statusDate,
            style: customTextStyle.copyWith(
              color: Colors.black45,
              fontSize: 14,
              fontWeight: FontWeight.normal
            ),
          ),
        );
      },
    );
  }
}