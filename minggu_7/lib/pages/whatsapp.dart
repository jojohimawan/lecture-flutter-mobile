import 'package:flutter/material.dart';
import 'package:minggu_7/theme/theme.dart';
import 'package:minggu_7/widgets/call_view.dart';
import 'package:minggu_7/widgets/chat_view.dart';
import 'package:minggu_7/widgets/community_view.dart';
import 'package:minggu_7/widgets/update_view.dart';

class Whatsapp extends StatefulWidget {
  const Whatsapp({super.key});

  @override
  State<Whatsapp> createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> {
  int currentPageIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ChatView(),
    UpdateView(),
    CommunityView(),
    CallView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whatsappPrimary,
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            fontWeight: FontWeight.normal
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.camera_alt_outlined),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.grey[50],
        indicatorColor: Colors.grey[300],
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Badge(
              backgroundColor: whatsappSecondary,
              label: const Text('99+'),
              child: const Icon(Icons.chat),
            ),
            icon: Badge(
              backgroundColor: whatsappSecondary,
              label: const Text('99+'),
              child: const Icon(Icons.chat_outlined),
            ),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Badge(
              backgroundColor: whatsappSecondary,
              child: const Icon(Icons.rotate_right_outlined),
            ),
            label: 'Updates',
          ),
          const NavigationDestination(
            selectedIcon: Icon(
              Icons.groups
            ),
            icon: Icon(Icons.groups_outlined),
            label: 'Communities',
          ),
          const NavigationDestination(
            selectedIcon: Icon(
              Icons.call
            ),
            icon: Icon(Icons.call_outlined),
            label: 'Calls',
          ),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        backgroundColor: whatsappSecondary,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(16)
//        ),
//        child: Icon(
//          Icons.add
//        ),
//      ),
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex),
      )
    );
  }
}
