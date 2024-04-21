import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minggu_8_miniproj/database/music_database.dart';
import 'package:minggu_8_miniproj/models/favorites.dart';
import 'package:minggu_8_miniproj/models/musiclist.dart';
import 'package:minggu_8_miniproj/pages/play_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Musiclist> _musiclist = [];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _refreshMusiclist();
  }

  Future<void> _refreshMusiclist() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _musiclist = await MusicDatabase.instance.getSongsInFavorites();
      if(_musiclist.isEmpty) {
        // await MusicDatabase.instance.populateMusicList();
      } 
      debugPrint('fetching music...');
    } catch(e) {
      SnackBar(content: Text('Error'),);
    } finally {
      setState(() {
      _isLoading = false;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildMusicList();
  }


  Widget _buildMusicList() {
    return 
     _isLoading 
      ? const Center(
              child: CircularProgressIndicator(),
            )
      : _musiclist.isEmpty
      ? const Center(child: Text('Kosong'))
      : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text('Your Loved Songs',
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _musiclist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PlayPage(music: _musiclist[index])));
                      },
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: AspectRatio(
                          aspectRatio: 1/1,
                          child: Image.asset(
                            'assets/image/player_image.jpeg',
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        _musiclist[index].title.contains('-')
                        ?  _musiclist[index].title.replaceAll('-', ' ')
                        : _musiclist[index].title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await MusicDatabase.instance.removeFromFavorites(_musiclist[index].id!);
                          _refreshMusiclist();
                        },
                        icon: const Icon(CupertinoIcons.clear),
                      ),
                    );
                  })
            ],
          ),
        ),
      );
  }
}