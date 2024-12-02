import 'package:calorie_counter/models/Recipe.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBRecipes {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "DBRecipes.db");

    // Elimina la base de datos si ya existe (forzar la recreación)
    //await deleteDatabase(path);

    return await openDatabase(
      'recipes_database.db',
      version: 4, // Incrementa la versión si es necesario
      onCreate: (db, version) async {
        // Crea la tabla si es la primera vez
        await db.execute('''
      CREATE TABLE Recipe (
        id INTEGER PRIMARY KEY,
        name TEXT,
        ingredients TEXT,
        preparationSteps TEXT,
        imagePath TEXT
      )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          // Realiza la migración de la base de datos (si es necesario)
          await db.execute('''
          ALTER TABLE Recipe ADD COLUMN imagePath TEXT
        ''');
        }
      },
    );
  }

  addNewRecipe(Recipe recipe) async {
    final db = await database;
    final response = await db.insert(
      'Recipe',
      recipe.toJson(),
    );
    return response;
  }

  Future<List<Recipe>> getAllRecipes() async {
    final db = await database;
    final response = await db.query('Recipe');

    List<Recipe> fList = response.isNotEmpty
        ? response.map((e) => Recipe.fromJson(e)).toList()
        : [];

    return fList;
  }

  // Método para obtener comidas de una fecha específica
  Future<List<Recipe>> getRecipesByDate(String date) async {
    final db = await database;
    final response = await db.query(
      'Recipe',
      where: 'createdAt = ?',
      whereArgs: [date],
    );

    List<Recipe> rList = response.isNotEmpty
        ? response.map((e) => Recipe.fromJson(e)).toList()
        : [];

    return rList;
  }
}
