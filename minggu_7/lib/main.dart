import 'package:flutter/material.dart';
import 'package:minggu_7/pages/whatsapp.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Whatsapp(),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
