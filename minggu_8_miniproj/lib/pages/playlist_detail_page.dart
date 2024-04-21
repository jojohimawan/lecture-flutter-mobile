import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minggu_8_miniproj/models/musiclist.dart';
import 'package:minggu_8_miniproj/models/playlist.dart';
import 'package:minggu_8_miniproj/database/music_database.dart';
import 'package:minggu_8_miniproj/pages/play_page.dart';
import 'package:minggu_8_miniproj/widgets/musiclist.dart';

class PlaylistDetailPage extends StatefulWidget {
  const PlaylistDetailPage({super.key, required this.playlist});
  final Playlist playlist;

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  List<Musiclist> _musiclist = [];
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshMusiclist();
  }

  Future<void> _refreshMusiclist() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _musiclist = await MusicDatabase.instance.getSongsInPlaylist(widget.playlist.id!);
      debugPrint('fetching playlist...');
    } catch(e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
      _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.playlist.name,
          style: const TextStyle(
            fontSize: 16
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await _displayBottomSheet(context);
                    Navigator.pop(context, true);
                  },
                  icon: Icon(CupertinoIcons.pencil),
                ),
                IconButton(
                  onPressed: () async {
                    await MusicDatabase.instance.deletePlaylistById(widget.playlist.id!);
                    Navigator.pop(context, true);
                  },
                  icon: Icon(CupertinoIcons.delete),
                )
              ],
            )
            ,
          )
        ],
      ),
      body: _isLoading 
      ? const Center(
              child: CircularProgressIndicator(),
            )
      : _musiclist.isEmpty
      ? const Center(child: Text('Kosong'))
      : _buildMusicList(),
    );
  }

  Widget _buildMusicList() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text('Playlist: ${widget.playlist.name}',
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
                            builder: (_) => PlayPage(music: _musiclist[index], playlist: widget.playlist)));
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

  Future _displayBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = widget.playlist.name;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Container(
          height: 200,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: name,
                    decoration: const InputDecoration(
                      hintText: 'Playlist Title',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none
                    ),
                    onChanged: (value) => name = value,
                    validator: (_name) {
                      return _name != null && _name.isEmpty ? 'title cant be empty' : null;
                    } ,
                  ),
                  const SizedBox(height: 24,),
                  ElevatedButton(
                    onPressed: () async {
                      final isValid = formKey.currentState!.validate();
                      if(isValid) {
                        await _updatePlaylist(name);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[50],
                      elevation: 0
                    ),
                    child: const Text('Update Playlist'),
                  )
                ],
              )
            ),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16)
        )
      ),
    );
  }

  Future<void> _updatePlaylist(String name) async {
    final newPlaylist = Playlist(
      id: widget.playlist.id,
      name: name
    );

    await MusicDatabase.instance.updatePlaylist(newPlaylist);
  }
}