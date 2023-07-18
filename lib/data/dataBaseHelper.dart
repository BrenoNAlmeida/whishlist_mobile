import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wishlist/models/User.dart';
import 'package:wishlist/models/Wish.dart';
import 'package:wishlist/models/WishList.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id TEXT PRIMARY KEY,
        username TEXT,
        nome TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS wish_lists(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        user TEXT,
        FOREIGN KEY (user) REFERENCES users (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS wishes(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        link TEXT,
        wish_list TEXT,
        FOREIGN KEY (wish_list) REFERENCES wish_lists (id)
      )
    ''');
  }

  Future<void> addUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (index) {
      return User.fromMap(maps[index]);
    });
  }

  Future<void> addWishList(WishList wishList) async {
    final db = await database;
    await db.insert('wish_lists', wishList.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<WishList>> getWishLists() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('wish_lists');
    return List.generate(maps.length, (index) {
      return WishList.fromMap(maps[index]);
    });
  }

  Future<void> addWish(Wish wish) async {
    final db = await database;
    await db.insert('wishes', wish.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Wish>> getWishes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('wishes');
    return List.generate(maps.length, (index) {
      return Wish.fromMap(maps[index]);
    });
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> updateWishList(WishList wishList) async {
    final db = await database;
    return await db.update(
      'lists',
      wishList.toMap(),
      where: 'id = ?',
      whereArgs: [wishList.id],
    );
  }

  Future<int> updateWish(Wish wish) async {
    final db = await database;
    return await db.update(
      'wishes',
      wish.toMap(),
      where: 'id = ?',
      whereArgs: [wish.id],
    );
  }
}
