import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:minggu_8_miniproj/models/musiclist.dart';
import 'package:minggu_8_miniproj/pages/favorites_page.dart';
import 'package:minggu_8_miniproj/widgets/musiclist.dart';
import 'package:minggu_8_miniproj/widgets/playlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MusicListPage(),
    PlaylistPage(),
    FavoritesPage()
  ];

  static const List<Widget> _appBarOptions = <Widget>[
    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                'Home',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                ),
                Text(
                'Browse All The Music',
                style: TextStyle(fontSize: 12,)
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                'Playlist',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                ),
                Text(
                'Personalized Musics',
                style: TextStyle(fontSize: 12,)
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                'Favorites',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                ),
                Text(
                'The Special Ones',
                style: TextStyle(fontSize: 12,)
                ),
              ],
            ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        toolbarHeight: 80,
        centerTitle: false,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/image/avatar.jpg'),
            ),
            const SizedBox(width: 14,),
            _appBarOptions[currentPageIndex]
          ]
        ),
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
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(CupertinoIcons.music_note),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.music_albums_fill),
            label: 'Playlist',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.heart_fill),
            label: 'Favorites',
          ),
        ],
      ),
      body: _widgetOptions.elementAt(currentPageIndex)
    );
  }
}