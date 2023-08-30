import 'package:chat_app/data/news/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("notifications.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''
    CREATE TABLE ${NewsModelFields.table_name} (
    ${NewsModelFields.id} $idType,
    ${NewsModelFields.author} $textType,
    ${NewsModelFields.news_image} $textType,
    ${NewsModelFields.news_description} $textType,
    ${NewsModelFields.news_date} $textType,
    ${NewsModelFields.news_title} $textType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }

  static Future<NewsModelSql> insertNews(
      NewsModelSql newsModelSql) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        NewsModelFields.table_name, newsModelSql.toJson());
    return newsModelSql.copyWith(id: id);
  }

  static Future<List<NewsModelSql>> getAllNews() async {
    List<NewsModelSql> allNews = [];
    final db = await getInstance.database;
    allNews = (await db.query(NewsModelFields.table_name))
        .map((e) => NewsModelSql.fromJson(e))
        .toList();

    return allNews;
  }

  static updateNewsAuthor({required int id, required String author}) async {
    final db = await getInstance.database;
    db.update(
      NewsModelFields.table_name,
      {NewsModelFields.author: author},
      where: "${NewsModelFields.id} = ?",
      whereArgs: [id],
    );
  }

  static updateNews({required NewsModelSql newsModelSql}) async {
    final db = await getInstance.database;
    db.update(
      NewsModelFields.table_name,
      newsModelSql.toJson(),
      where: "${NewsModelFields.id} = ?",
      whereArgs: [newsModelSql.id],
    );
  }

  static Future<int> deleteNews(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      NewsModelFields.table_name,
      where: "${NewsModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }

  static Future<List<NewsModelSql>> getNewsByLimit(int limit) async {
    List<NewsModelSql> allNews = [];
    final db = await getInstance.database;
    allNews = (await db.query(NewsModelFields.table_name,
        limit: limit, orderBy: "${NewsModelFields.author} ASC"))
        .map((e) => NewsModelSql.fromJson(e))
        .toList();

    return allNews;
  }

  static Future<NewsModelSql?> getSingleNews(int id) async {
    List<NewsModelSql> news = [];
    final db = await getInstance.database;
    news = (await db.query(
      NewsModelFields.table_name,
      where: "${NewsModelFields.id} = ?",
      whereArgs: [id],
    ))
        .map((e) => NewsModelSql.fromJson(e))
        .toList();

    if (news.isNotEmpty) {
      return news.first;
    }
  }

  static Future<List<NewsModelSql>> getNewsByAlphabet(
      String order) async {
    List<NewsModelSql> allNews = [];
    final db = await getInstance.database;
    allNews = (await db.query(NewsModelFields.table_name,
        orderBy: "${NewsModelFields.author} $order"))
        .map((e) => NewsModelSql.fromJson(e))
        .toList();
    return allNews;
  }
}