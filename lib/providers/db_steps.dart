import 'package:calorie_counter/models/Step.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class StepsDatabase {
  static final StepsDatabase instance = StepsDatabase._init();
  Database? _database;

  StepsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'steps_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Steps (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            stepCount INTEGER NOT NULL,
            date TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> addSteps(Step step) async {
    final db = await database;
    return await db.insert('Steps', step.toJson());
  }

  Future<List<Step>> getStepsByDate(String date) async {
    final db = await database;
    final response = await db.query(
      'Steps',
      where: 'date = ?',
      whereArgs: [date],
    );

    return response.isNotEmpty
        ? response.map((e) => Step.fromJson(e)).toList()
        : [];
  }

  Future<int> updateStepsForDate(String date, int stepCount) async {
    final db = await database;
    return await db.update(
      'Steps',
      {'stepCount': stepCount},
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future<int> deleteStepsForDate(String date) async {
    final db = await database;
    return await db.delete(
      'Steps',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future close() async {
    final db = await _database;
    db?.close();
  }
}
