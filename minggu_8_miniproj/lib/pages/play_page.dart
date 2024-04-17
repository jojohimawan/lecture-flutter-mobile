import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _setAudio();
    
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
    audioPlayer.dispose();
    super.dispose();
  }

  Future _setAudio() async {
    // repeat music after finish
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    // load music
    final player = AudioCache();
    final url = await player.load('audio/sdp-interlude.mp3');
    audioPlayer.setSourceUrl(url.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Padding(
      padding: EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Text(
            'sdp-interlude',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple[900]),
          ),
          Text(
            'From Playlist: Mornin Chill',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple[200]),
          )
        ],
      ),
    );
  }

  Widget _buildMusicSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.heart_fill,
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
                    onTap: () {},
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
}
