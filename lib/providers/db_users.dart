import 'package:calorie_counter/models/users_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBUsers {
  static Database? _database;
  static final DBUsers db = DBUsers._();
  DBUsers._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "UserDB.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE User (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT
        )
        ''');
    });
  }

  addNewUser(UsersModel user) async {
    final db = await database;
    final response = db.insert('User', user.toJson());
    return response;
  }

  Future<List<UsersModel>> getAllUsers() async {
    final db = await database;
    final response = await db.query('User');

    List<UsersModel> uList = response.isNotEmpty
        ? response.map((e) => UsersModel.fromJson(e)).toList()
        : [];

    return uList;
  }
}