import 'package:calorie_counter/models/category_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBFeatures {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "FeatureDB.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Feature (
      id INTEGER PRIMARY KEY,
      category TEXT,
      color TEXT,
      icon TEXT
      )
      ''');

      // Insertar categorías iniciales
      List<CategoryModel> initialCategories = [
        CategoryModel(
            id: 1,
            categoryName: 'Frutas',
            color: '#087802',
            icon: 'Icon_apple'),
        CategoryModel(
            id: 2,
            categoryName: 'Verduras',
            color: '#3f9bfc',
            icon: 'Icon_grass'),
        CategoryModel(
            id: 3,
            categoryName: 'Postres',
            color: '#ff8605',
            icon: 'Icon_cake'),
      ];

      for (var category in initialCategories) {
        await db.insert('Feature', category.toJson());
      }
    });
  }

  addNewFeature(CategoryModel feature) async {
    final db = await database;
    final response = db.insert('Feature', feature.toJson());
    return response;
  }

  Future<List<CategoryModel>> getAllFeatures() async {
    final db = await database;
    final response = await db.query('Feature');

    List<CategoryModel> fList = response.isNotEmpty
        ? response.map((e) => CategoryModel.fromJson(e)).toList()
        : [];

    return fList;
  }

  Future<int> updateFeatures(CategoryModel features) async {
    final db = await database;
    final response = db.update('Feature', features.toJson(),
        where: 'id = ?', whereArgs: [features.id]);
    return response;
  }
}
