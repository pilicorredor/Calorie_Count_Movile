import 'package:calorie_counter/models/food.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBFood {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "DBFood.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS Food (
        id INTEGER PRIMARY KEY,
        name TEXT,
        quantity DOUBLE,
        unit TEXT,
        calories DOUBLE,
        createdAt TEXT,
        categoryId INTEGER,
        FOREIGN KEY (categoryId) REFERENCES Feature(id)
        )
        ''');
    });
  }

  addNewFood(Food food) async {
    final db = await database;
    final response = db.insert('Food', food.toJson());
    return response;
  }

  Future<List<Food>> getAllFoods() async {
    final db = await database;
    final response = await db.query('Food');

    List<Food> fList = response.isNotEmpty
        ? response.map((e) => Food.fromJson(e)).toList()
        : [];

    return fList;
  }

  // Método para obtener comidas de una fecha específica
  Future<List<Food>> getFoodsByDate(String date) async {
    final db = await database;
    final response = await db.query(
      'Food',
      where: 'createdAt = ?',
      whereArgs: [date],
    );

    List<Food> fList = response.isNotEmpty
        ? response.map((e) => Food.fromJson(e)).toList()
        : [];

    return fList;
  }

  // Método para obtener comidas de una categoría específica
  Future<List<Food>> getFoodsByCategory(int categoryId) async {
    final db = await database;
    final response = await db
        .query('Food', where: 'categoryId = ?', whereArgs: [categoryId]);

    List<Food> fList = response.isNotEmpty
        ? response.map((e) => Food.fromJson(e)).toList()
        : [];

    return fList;
  }
}
