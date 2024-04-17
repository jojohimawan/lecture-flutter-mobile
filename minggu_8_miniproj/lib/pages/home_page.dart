import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    'Quick Picks',
                    style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.w500)
                    ),
                ),
                _buildSongListTile(),
                _buildSongListTile(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Quick Playlist',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
                _buildQuickPlaylist()
              ],
            ),
          ),
        ));
  }

  Widget _buildSongListTile() {
    return ListTile(
      onTap: () {},
      leading: Image.network(
        'https://upload.wikimedia.org/wikipedia/en/f/f6/Juice_Wrld_-_Legends_Never_Die.png',
        height: 48,
      ),
      title: const Text(
        'Wishing Well',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      subtitle: const Text(
        'Juice',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildQuickPlaylist() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 20,
                  color: Colors.purple[50],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 32,
                      ),
                      SizedBox(height: 12),
                      Text('Playlist One')
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 20,
                  color: Colors.purple[50],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 32,
                      ),
                      SizedBox(height: 12),
                      Text('Playlist Two')
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
