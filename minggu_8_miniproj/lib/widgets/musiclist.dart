import 'package:flutter/material.dart';

import 'package:minggu_8_miniproj/pages/play_page.dart';

import 'package:minggu_8_miniproj/database/music_database.dart';
import 'package:minggu_8_miniproj/models/musiclist.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key, this.musiclist});

  final List<Musiclist>? musiclist;

  @override
  State<MusicListPage> createState() => MusicListPageState();
}

class MusicListPageState extends State<MusicListPage> {
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
      _musiclist = await MusicDatabase.instance.getAllMusiclist();
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
    return  _isLoading 
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
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text('Global Library',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.musiclist?.length ?? _musiclist.length,
                  itemBuilder: (context, index) {
                    final music = widget.musiclist?[index] ?? _musiclist[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PlayPage(music: music)));
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    );
                  })
            ],
          ),
        ),
      );
  }
}
