import 'package:calorie_counter/models/category_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBFEatures {
  static Database? _database;
  static final DBFEatures db = DBFEatures._();
  DBFEatures._();

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
        CREATE TABLE Feature (
        id INTEGER PRIMARY KEY,
        category TEXT,
        color TEXT,
        icon TEXT
        )
        ''');
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
