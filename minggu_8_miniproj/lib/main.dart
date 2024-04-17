import 'package:flutter/material.dart';
import 'package:minggu_8_miniproj/pages/home_page.dart';
import 'package:minggu_8_miniproj/pages/musiclist_page.dart';
import 'package:minggu_8_miniproj/pages/play_page.dart';
import 'package:minggu_8_miniproj/pages/playlist_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:minggu_8_miniproj/pages/splash_page.dart';
import 'package:minggu_8_miniproj/pages/login_page.dart';
import 'package:minggu_8_miniproj/pages/account_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://hacxaardsztdbsjmzilc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhhY3hhYXJkc3p0ZGJzam16aWxjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTMxOTAzMTcsImV4cCI6MjAyODc2NjMxN30.CU_DWYaeGfA-uBiVkwUIqXKP3z5MkBLr5j18ejNYr3Y'
  );

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Lagu',
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (_) => PlayPage(),
        '/music': (_) => MusicListPage(),
        '/playlist': (_) => PlaylistPage(),
        '/play': (_) => PlayPage(),
        '/splash': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage()
      },
    );
  }
}