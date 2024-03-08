import 'package:flutter/material.dart';
import 'package:minggu_3_whatsappui/theme.dart';
import 'package:minggu_3_whatsappui/widgets/call_view.dart';
import 'package:minggu_3_whatsappui/widgets/chat_view.dart';
import 'package:minggu_3_whatsappui/widgets/status_view.dart';

class WhatsAppPage extends StatefulWidget {
  const WhatsAppPage({super.key});

  @override
  State<WhatsAppPage> createState() => _WhatsAppPageState();
}

class _WhatsAppPageState extends State<WhatsAppPage> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = [
    const Tab(icon: Icon(Icons.camera_alt)),
    const Tab(text: 'Chat'),
    const Tab(text: 'Status'),
    const Tab(text: 'Call')
  ];
  TabController? tabController;
  var fabIcon = Icons.message;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: tabs.length,
      vsync: this
    );

    tabController?.index = 1;
    tabController?.addListener(() {
      setState(() {
        switch(tabController?.index) {
          case 0: 
            fabIcon = Icons.camera;
            break;
          case 1: 
            fabIcon = Icons.message;
            break;
          case 2: 
            fabIcon = Icons.add;
            break;
          case 3: 
            fabIcon = Icons.call;
            break;
          default:
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whatsAppGreen,
        title: const Text('WhatsApp'),
        actions: const [
          Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.more_vert),
          )
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: tabs,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          Center(child: Icon(Icons.camera_alt)),
          ChatView(),
          StatusView(),
          CallView()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: whatsAppLightGreen,
        child: Icon(fabIcon),
      ),
    );
  }
}