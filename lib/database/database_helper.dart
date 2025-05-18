import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'users.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
         CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT UNIQUE NOT NULL,
          senha TEXT NOT NULL
        )
      ''');
    });
  }




  static Future<void> insertUser(String email, String senha) async {
    final dbClient = await db;
    await dbClient.insert(
      'users',
      {'email': email, 'senha': senha},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<bool> login(String email, String senha) async {
    final dbClient = await db;
    final result = await dbClient.query(
      'users',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty;
  }
}
