import 'package:flutter/material.dart';
import 'package:minggu_8_miniproj/models/playlist.dart';
import 'package:minggu_8_miniproj/database/music_database.dart';
import 'package:minggu_8_miniproj/database/music_database.dart';
import 'package:minggu_8_miniproj/pages/playlist_detail_page.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<Playlist> _playlist = [];
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshPlaylist();
  }

  Future<void> _refreshPlaylist() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _playlist = await MusicDatabase.instance.getAllPlaylist();
      debugPrint('fetching playlist...');
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
    return _isLoading 
      ? const Center(
              child: CircularProgressIndicator(),
            )
      : SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text('Your Library',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () {
                        _displayBottomSheet(context);
                      },
                      child: const Text(
                        'New Playlist',
                        style: TextStyle(
                          fontSize: 14
                        )
                      ),
                    )
                  ),
                  
                ],
              ),
              _playlist.isEmpty
                  ? const Center(child: Text('kosong'))
                  : _buildPlaylistGrid()
            ],
          ),
      );
  }

  Widget _buildPlaylistGrid() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                  children: List.generate(
                    _playlist.length, (i) {
                        return GestureDetector(
                        onTap: () async {
                          final res = await Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PlaylistDetailPage(
                              playlist: _playlist[i],
                              )));
                          if (res == true) {
                            _refreshPlaylist();
                          }
                        },
                        child: Container(
                          height: 20,
                          color: Colors.purple[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 32,
                              ),
                              const SizedBox(height: 12),
                              Text(_playlist[i].name)
                            ],
                          ),
                        ),
                      );
                    }
                  )
                ),
              );
  }

  Future _displayBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = '';

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
                        await _createPlaylist(name);
                        _refreshPlaylist();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[50],
                      elevation: 0
                    ),
                    child: Text('Create Playlist'),
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

  Future<void> _createPlaylist(String name) async {
    final playlist = Playlist(
      name: name
    );

    await MusicDatabase.instance.createPlaylist(playlist);
  }
}
