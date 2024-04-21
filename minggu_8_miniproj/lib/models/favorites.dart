const String tableFavorites = 'favorites';

class FavoritesFields {
  static const String music_id = 'music_id';
}

class Favorites {
  final int? music_id;

  const Favorites({
    this.music_id,
  });

  Favorites copy({ int? music_id }) {
    return Favorites(music_id: music_id ?? this.music_id);
  }

  static Favorites fromJson(Map<String, Object?> json) {
    return Favorites(
      music_id: json[FavoritesFields.music_id] as int?,
    );
  }

  Map<String, Object?> toJson() => {
    FavoritesFields.music_id: music_id,
  };
}