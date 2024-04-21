const String tablePlaylistToMusic = 'playlist_to_music';

class PlaylistToMusicFields {
  static const String id = 'id';
  static const String playlist_id = 'playlist_id';
  static const String music_id = 'music_id';
}

class PlaylistToMusic {
  final int? id;
  final int playlist_id;
  final int music_id;

  const PlaylistToMusic({
    this.id,
    required this.playlist_id,
    required this.music_id
  });

  PlaylistToMusic copy({ int? id, int? playlist_id, int? music_id }) {
    return PlaylistToMusic(
      id: id,
      playlist_id: playlist_id ?? this.playlist_id,
      music_id: music_id ?? this.music_id  
    );
  }

  static PlaylistToMusic fromJson(Map<String, Object?> json) {
    return PlaylistToMusic(
      id: json[PlaylistToMusicFields.id] as int?,
      playlist_id: json[PlaylistToMusicFields.playlist_id] as int,
      music_id: json[PlaylistToMusicFields.music_id] as int
    );
  }

  Map<String, Object?> toJson() => {
    PlaylistToMusicFields.id: id,
    PlaylistToMusicFields.playlist_id: playlist_id,
    PlaylistToMusicFields.music_id: music_id
  };
}