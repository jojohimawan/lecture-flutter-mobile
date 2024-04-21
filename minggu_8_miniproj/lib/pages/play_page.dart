import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minggu_8_miniproj/database/music_database.dart';
import 'package:minggu_8_miniproj/models/favorites.dart';
import 'package:minggu_8_miniproj/models/musiclist.dart';
import 'package:minggu_8_miniproj/models/playlist.dart';
import 'package:minggu_8_miniproj/models/playlist_to_music.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key, required this.music, this.playlist});
  final Musiclist music;
  final Playlist? playlist;

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool _isPlaying = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    debugPrint('path ${widget.music.title}');
    _setAudio();
    _checkIsFavorite();
    
    // listen to music event: playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        _isPlaying = event == PlayerState.playing;
        debugPrint('$_isPlaying');
      });
    });

    // listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) { 
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    debugPrint('disposed');
    audioPlayer.dispose();
    super.dispose();
  }

  Future _setAudio() async {
    // repeat music after finish
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    // load music
    final player = AudioCache();
    final url = await player.load('audio/${widget.music.title}.mp3');
    audioPlayer.setSourceUrl(url.path);
  }

  Future _checkIsFavorite() async {
    final result = await MusicDatabase.instance.checkIfFavorites(widget.music.id!);
    if(result != 0) {
      setState(() {
        _isFavorite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Playing From',
              style: TextStyle(
                fontSize: 16
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.playlist?.name ?? 'Library',
              style: const TextStyle(
                fontSize: 12
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPlayerImage(),
            _buildMusicData(),
            _buildMusicSlider(),
            _buildMusicController()
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Image.asset(
          'assets/image/player_image.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMusicData() {
    return Text(
            widget.music.title.contains('-')
            ?  widget.music.title.replaceAll('-', ' ')
            : widget.music.title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple[900]),
          );
  }

  Widget _buildMusicSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioPlayer.seek(position);

              // resume music if paused
              await audioPlayer.resume();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatTime(position),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[600])),
              Text(
                _formatTime(duration - position),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[600]))
            ],
          )
        ],
      ),
    );
  }


  Widget _buildMusicController() {
    return Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if(_isFavorite == true) {
                        Fluttertoast.showToast(msg: 'Already in favorite');
                      } else {
                          await _addToFavorites(widget.music.id!);
                          setState(() {
                            _isFavorite = true;
                          });
                      }
                    },
                    child: Icon(
                      _isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                      color: Colors.red[500],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.arrow_left_to_line,
                      color: Colors.black,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      if(_isPlaying) {
                        debugPrint('paused');
                        await audioPlayer.pause();
                      } else {
                        debugPrint('resumed');
                        await audioPlayer.resume();
                      }
                    },
                    elevation: 0,
                    highlightElevation: 0,
                    child: _isPlaying 
                            ? Icon(CupertinoIcons.pause)
                            : Icon(CupertinoIcons.play_fill),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.arrow_right_to_line,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _displayBottomSheet(context, widget.music.id!);
                    },
                    child: Icon(
                      CupertinoIcons.add,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(':');
  }

  Future _displayBottomSheet(BuildContext context, int musicId) async {
    List<Playlist> availablePlaylist = await MusicDatabase.instance.getAllPlaylist();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Container(
          height: 200,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: availablePlaylist.isEmpty
            ? Text('No Playlist Available', textAlign: TextAlign.center)
            : ListView.builder(
              shrinkWrap: true,
              itemCount: availablePlaylist.length,
              itemBuilder: (context, index)  {
                return ElevatedButton(
                  onPressed: () async {
                    if(_isFavorite == false) {
                      await _addToFavorites(widget.music.id!);
                      setState(() {
                        _isFavorite = true;
                      });
                    }
                  },
                  child: Text(
                    availablePlaylist[index].name
                  ),
                );
              }
            )
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

  Future<PlaylistToMusic> _createPlaylist(int? playlistId, int musicId) async {
    final playlistToMusic = PlaylistToMusic(
      music_id: musicId,
      playlist_id: playlistId!
    );

    final result = await MusicDatabase.instance.addMusicToPlaylist(playlistToMusic);
    debugPrint(result.id.toString());
    return result;
  }

  Future<Favorites> _addToFavorites(int musicId) async {
    final favorites = Favorites(
      music_id: musicId
    );

    final result = await MusicDatabase.instance.addToFavorites(favorites);
    return result;
  }

}
