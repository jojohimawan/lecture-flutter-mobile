import 'package:flutter/material.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildCommunityItem()
      ],
    );
  }

  Widget buildCommunityItem() {
    return Column(
      children: [
        const Row(
          children: [
            CircleAvatar(),
            Text('EXTEEnd')
          ],
        ),
        buiildCommunityChats(),
        buiildCommunityChats(),
        buiildCommunityChats()
      ],
    );
  }

  Widget buiildCommunityChats() {
    return const Row(
      children: [
        CircleAvatar(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('HEADER'),
            Text('CHILD')
          ],
        )
      ],
    );
  }
}