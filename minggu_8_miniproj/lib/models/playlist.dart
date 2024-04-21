const String tablePlaylist = 'playlist';

class PlaylistFields {
  static const String id = 'id';
  static const String name = 'name';
}

class Playlist {
  final int? id;
  final String name;

  const Playlist({
    this.id,
    required this.name
  });

  Playlist copy({ int? id, String? name }) {
    return Playlist(id: id, name: name ?? this.name);
  }

  static Playlist fromJson(Map<String, Object?> json) {
    return Playlist(
      id: json[PlaylistFields.id] as int?,
      name: json[PlaylistFields.name] as String
    );
  }

  Map<String, Object?> toJson() => {
    PlaylistFields.id: id,
    PlaylistFields.name: name
  };
}