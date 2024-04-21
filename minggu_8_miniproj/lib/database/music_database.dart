import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:minggu_8_miniproj/models/playlist.dart';
import 'package:minggu_8_miniproj/models/musiclist.dart';
import 'package:minggu_8_miniproj/models/playlist_to_music.dart';
import 'package:minggu_8_miniproj/models/favorites.dart';

class MusicDatabase {
  static final MusicDatabase instance = MusicDatabase._init();

  MusicDatabase._init();

  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('song.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const sqlCreatePlaylist = '''CREATE TABLE $tablePlaylist (
      ${PlaylistFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PlaylistFields.name} TEXT NOT NULL
    )''';
    const sqlCreateMusiclist = '''CREATE TABLE $tableMusiclist (
      ${MusiclistFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${MusiclistFields.title} TEXT NOT NULL
    )''';
    const sqlCreatePlaylistToMusic = '''CREATE TABLE $tablePlaylistToMusic (
      ${PlaylistToMusicFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PlaylistToMusicFields.playlist_id} INTEGER,
      ${PlaylistToMusicFields.music_id} INTEGER,
      FOREIGN KEY (${PlaylistToMusicFields.playlist_id}) REFERENCES $tablePlaylist (${PlaylistFields.id}) ON DELETE CASCADE,
      FOREIGN KEY (${PlaylistToMusicFields.music_id}) REFERENCES $tableMusiclist (${MusiclistFields.id}) ON DELETE CASCADE
    );''';
    const sqlCreateFavorites = '''CREATE TABLE $tableFavorites (
      ${FavoritesFields.music_id} INTEGER,
      FOREIGN KEY (${FavoritesFields.music_id}) REFERENCES $tableMusiclist (${MusiclistFields.id}) ON DELETE CASCADE
    )''';
    
    await db.execute(sqlCreatePlaylist);
    await db.execute(sqlCreateMusiclist);
    await db.execute(sqlCreatePlaylistToMusic);
    await db.execute(sqlCreateFavorites);
  }

  Future<void> populateMusicList() async {
    final db = await instance.database;
    // Logic to populate the musiclist table
    final List<Map<String, dynamic>> musicListData = [
      { MusiclistFields.title: 'Amakane-Wawawa' },
      { MusiclistFields.title: 'Cincin' },
      { MusiclistFields.title: 'Closer' },
      { MusiclistFields.title: 'December' },
      { MusiclistFields.title: 'Drown' },
      { MusiclistFields.title: 'Go-Again' },
      { MusiclistFields.title: 'HUMBLE' },
      { MusiclistFields.title: 'LosT' },
      { MusiclistFields.title: 'No-One-Can-Stop-Us' },
      { MusiclistFields.title: 'Ruang' },
      { MusiclistFields.title: 'sdp-interlude' },
      { MusiclistFields.title: 'Space-Cadet' },
      // Add more songs as needed
    ];

    for (final musicData in musicListData) {
      await db.insert(
        tableMusiclist,
        musicData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<Favorites> addToFavorites(Favorites favorites) async {
    final db = await instance.database;
    final id = await db.insert(tableFavorites, favorites.toJson());
    return favorites.copy(music_id: id);
  }

  Future<int> removeFromFavorites(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableFavorites,
      where: '${FavoritesFields.music_id} = ?',
      whereArgs: [id]
    );
  }


  Future<List<Musiclist>> getSongsInFavorites() async {
    final db = await instance.database;
    
    final songs = await db.rawQuery('''
      SELECT $tableMusiclist.*
      FROM $tableFavorites
      JOIN $tableMusiclist ON $tableFavorites.${FavoritesFields.music_id} = $Musiclist.${MusiclistFields.id}
    ''');


    return songs.map((json) => Musiclist.fromJson(json)).toList();
  }

  Future<int> checkIfFavorites(int musicId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
    'SELECT COUNT(*) AS count FROM $tableFavorites WHERE ${FavoritesFields.music_id} = ?',
    [musicId],
    );

    int count = Sqflite.firstIntValue(result)!;
    return count;
  }

  Future<Playlist> createPlaylist(Playlist playlist) async {
    final db = await instance.database;
    final id = await db.insert(tablePlaylist, playlist.toJson());
    return playlist.copy(id: id);
  }

  Future<List<Playlist>> getAllPlaylist() async {
    final db = await instance.database;
    final result = await db.query(tablePlaylist);
    return result.map((json) => Playlist.fromJson(json)).toList();
  }

  Future<Playlist> getPlaylistById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      tablePlaylist,
      where: '${PlaylistFields.id} = ?',
      whereArgs: [id]
    );
    
    if(result.isNotEmpty) {
      return Playlist.fromJson(result.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<int> deletePlaylistById(int id) async {
    final db = await instance.database;
    return await db.delete(
      tablePlaylist,
      where: '${PlaylistFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future<int> updatePlaylist(Playlist playlist) async {
    final db = await instance.database;
    return db.update(
      tablePlaylist,
      playlist.toJson(),
      where: '${PlaylistFields.id} = ?',
      whereArgs: [playlist.id]
    );
  }

  Future<List<Musiclist>> getAllMusiclist() async {
    final db = await instance.database;
    final result = await db.query(tableMusiclist);
    return result.map((json) => Musiclist.fromJson(json)).toList();
  }

  Future<Musiclist> getMusiclistById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      tableMusiclist,
      where: '${MusiclistFields.id} = ?',
      whereArgs: [id]
    );
    
    if(result.isNotEmpty) {
      return Musiclist.fromJson(result.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<PlaylistToMusic>> getAvailablePlaylist(int musicId) async {
    final db = await instance.database;
    final result =  await db.rawQuery(
      '''
      SELECT * 
      FROM $tablePlaylistToMusic 
      WHERE ${PlaylistToMusicFields.playlist_id} NOT IN 
      (SELECT ${PlaylistToMusicFields.playlist_id} 
      FROM $tablePlaylistToMusic 
      WHERE ${PlaylistToMusicFields.music_id} = ?)
    ''',
    [musicId],
    );

    return result.map((json) => PlaylistToMusic.fromJson(json)).toList();
  }

  Future<int> checkMusicExistence(int musicId, int playlistId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
    'SELECT COUNT(*) AS count FROM $tablePlaylistToMusic WHERE ${PlaylistToMusicFields.playlist_id} = ? AND ${PlaylistToMusicFields.music_id} = ?',
    [playlistId, musicId],
    );

    int count = Sqflite.firstIntValue(result)!;
    return count;
  }

  Future<PlaylistToMusic> addMusicToPlaylist(PlaylistToMusic playlistToMusic) async {
    int count = await checkMusicExistence(playlistToMusic.music_id, playlistToMusic.playlist_id);
    final db = await instance.database;

    if(count == 0) {
      final id = await db.insert(tablePlaylistToMusic, playlistToMusic.toJson());
      return playlistToMusic.copy(id: id);
    } else {
      throw Exception('song exist');
    }
  }

  Future<List<Musiclist>> getSongsInPlaylist(int playlistId) async {
    final db = await instance.database;
    
    final songs = await db.rawQuery('''
      SELECT $tableMusiclist.*
      FROM $tablePlaylistToMusic
      JOIN $tableMusiclist ON $tablePlaylistToMusic.${PlaylistToMusicFields.music_id} = $Musiclist.${MusiclistFields.id}
      WHERE $tablePlaylistToMusic.${PlaylistToMusicFields.playlist_id} = ?
    ''', [playlistId]);


    return songs.map((json) => Musiclist.fromJson(json)).toList();
  }
}