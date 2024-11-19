import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBSteps {
  Database? _database;
  final Logger _logger = Logger();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "DBSteps.db");

    return await openDatabase(
      path,
      version: 5, // Incrementa la versión si es necesario
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          // Crea la tabla Steps si aún no existe
          await db.execute('''
            CREATE TABLE Steps (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              date TEXT NOT NULL,
              stepCount INTEGER NOT NULL
            )
          ''');
        }
      },
    );
  }

  /// Agregar pasos para una fecha específica
  Future<void> addSteps(String date, int stepCount) async {
    final db = await database;

    int a = await db.insert(
      'Steps',
      {'date': date, 'stepCount': stepCount},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _logger.d("$a");
  }

  /// Obtener los pasos para una fecha específica
  Future<int> getStepsByDate(String date) async {
    final db = await database;
    final result = await db.query(
      'Steps',
      where: 'date = ?',
      whereArgs: [date],
    );

    if (result.isNotEmpty) {
      return result.first['stepCount'] as int;
    }

    return 0; // Devuelve 0 si no hay registros
  }

  /// Obtener todo el historial de pasos
  Future<List<Map<String, dynamic>>> getStepHistory() async {
    final db = await database;
    return await db.query('Steps', orderBy: 'date DESC');
  }
}
