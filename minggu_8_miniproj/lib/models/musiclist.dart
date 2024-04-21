const String tableMusiclist = 'musiclist';

class MusiclistFields {
  static const String id = 'id';
  static const String title = 'title';
}

class Musiclist {
  final int? id;
  final String title;

  const Musiclist({
    this.id,
    required this.title
  });

  Musiclist copy({ int? id, String? title }) {
    return Musiclist(id: id, title: title ?? this.title);
  }

  static Musiclist fromJson(Map<String, Object?> json) {
    return Musiclist(
      id: json[MusiclistFields.id] as int?,
      title: json[MusiclistFields.title] as String
    );
  }

  Map<String, Object?> toJson() => {
    MusiclistFields.id: id,
    MusiclistFields.title: title
  };
}