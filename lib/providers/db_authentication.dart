import 'package:calorie_counter/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbAuthentication {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "DBAuth.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users (
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        age INTEGER,
        weight INTEGER,
        height INTEGER,
        gender TEXT,
        goal TEXT,
        password TEXT
        )
        ''');
    });
  }

//Login
  Future<bool> login(User user) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "select ? from users where email = '${user.email}' AND password = '${user.password}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

//Sign Up
  Future<int> signup(User user) async {
    final Database db = await initDB();

    return db.insert('users', user.toJson());
  }

//Current User Datails
  Future<User?> getUser(String email) async {
    final Database db = await initDB();
    var responseUser =
        await db.query("users", where: "email = ?", whereArgs: [email]);
    return responseUser.isNotEmpty? User.fromJson(responseUser.first):null;
  }
}
