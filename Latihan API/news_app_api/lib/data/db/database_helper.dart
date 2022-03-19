import 'package:news_app_api/data/model/article.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
  static const String _tbBookmark = 'bookmark';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tbBookmark(
          url TEXT PRIMARY KEY,
          author TEXT,
          title TEXT,
          description TEXT,
          urlToImage TEXT,
          publishedAt TEXT,
          content TEXT
        )
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertBookmark(Article article) async {
    final db = await database;
    await db!.insert(_tbBookmark, article.toJson());
  }

  Future<List<Article>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tbBookmark);
    return results.map((e) => Article.fromJson(e)).toList();
  }

  Future<Map> getBookmarkByUrl(String url) async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db!.query(_tbBookmark, where: 'url = ?', whereArgs: [url]);
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String url) async {
    final db = await database;

    await db!.delete(
      _tbBookmark,
      where: 'url = ?',
      whereArgs: [url]
    );
  }
}
