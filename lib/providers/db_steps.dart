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
      version: 6, // Incrementa la versión si es necesario
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          // Crea la tabla Steps si aún no existe
          await db.execute('''
            CREATE TABLE Steps (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              date TEXT NOT NULL,
              initialCount INTEGER NOT NULL,
              finalCount INTEGER NOT NULL
            )
          ''');
        }
      },
    );
  }

  /// Agregar pasos para una fecha específica
  Future<void> addSteps(String date, int initialCount, int finalCount) async {
    final db = await database;

    int a = await db.insert(
      'Steps',
      {'date': date, 'initialCount': initialCount, 'finalCount': finalCount},
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
      int iCount = result.first['initialCount'] as int;
      int fCount = result.first['finalCount'] as int;
      return fCount-iCount;
    }

    return 0; // Devuelve 0 si no hay registros
  }

}
