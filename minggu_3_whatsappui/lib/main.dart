import 'package:flutter/material.dart';
import 'package:minggu_3_whatsappui/pages/whatsapp_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const WhatsAppPage(),
    );
  }
}
