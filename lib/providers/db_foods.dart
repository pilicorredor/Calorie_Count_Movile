import 'package:calorie_counter/models/Food.dart';
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

      // Elimina la base de datos si ya existe (forzar la recreación)
     //await deleteDatabase(path); // Asegúrate de proporcionar la ruta correcta


  return await openDatabase(
    'food_database.db',
    version: 4, // Incrementa la versión si es necesario
    onCreate: (db, version) async {
      // Crea la tabla si es la primera vez
      await db.execute('''
      CREATE TABLE Food (
        id INTEGER PRIMARY KEY,
        name TEXT,
        quantity DOUBLE,
        unit TEXT,
        calories DOUBLE,
        createdAt TEXT,
        categoryName TEXT,
        imagePath TEXT
      )
      ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 4) {
        // Realiza la migración de la base de datos (si es necesario)
        await db.execute('''
          ALTER TABLE Food ADD COLUMN imagePath TEXT
        ''');
      }
    },
  );
}

  addNewFood(Food food) async {
    final db = await database;
    final response = await db.insert(
      'Food',
      food.toJson(), // Usamos food.toJson() para agregar el objeto Food a la base de datos
    );
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
  Future<List<Food>> getFoodsByCategory(String categoryName) async {
    final db = await database;
    final response = await db
        .query('Food', where: 'categoryName = ?', whereArgs: [categoryName]);

    List<Food> fList = response.isNotEmpty
        ? response.map((e) => Food.fromJson(e)).toList()
        : [];

    return fList;
  }

  Future<List<Food>> getFoodsByCategoryAndDate(
      String categoryName, String date) async {
    final db = await database;
    final response = await db.query(
      'Food',
      where: 'categoryName = ? AND createdAt = ?',
      whereArgs: [categoryName, date],
    );

    List<Food> fList = response.isNotEmpty
        ? response.map((e) => Food.fromJson(e)).toList()
        : [];

    return fList;
  }
}
