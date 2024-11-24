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


  Future<double> getCaloriesFromSteps(String date) async {
    final db = await database;
    const double caloriesPerStep = 0.04;
    final result = await db.query(
      'Steps',
      where: 'date = ?',
      whereArgs: [date],
    );

    if (result.isNotEmpty) {
      int iCount = result.first['initialCount'] as int;
      int fCount = result.first['finalCount'] as int;
      return (fCount-iCount) * caloriesPerStep;
    }

    return 0; // Devuelve 0 si no hay registros
}

   Future<int> getFinalStepsByDate(String date) async {
    final db = await database;
    final result = await db.query(
      'Steps',
      where: 'date = ?',
      whereArgs: [date],
    );

    if (result.isNotEmpty) {
      return result.first['finalCount'] as int;
    }

    return 0; // Devuelve 0 si no hay registros
  }
  Future<bool> isTodayCreated(String date) async {
    final db = await database;
    final result = await db.query(
      'Steps',
      where: 'date = ?',
      whereArgs: [date],
    );

    return result.isNotEmpty; // Devuelve 0 si no hay registros
  }

  Future<void> updateFinalStepsByDate(String date, int finalCount) async {
  final db = await database;

  int updatedRows = await db.update(
    'Steps',
    {'finalCount': finalCount},
    where: 'date = ?',
    whereArgs: [date],
  );

  if (updatedRows > 0) {
    _logger.d("Se actualizaron los pasos finales para la fecha $date.");
  } else {
    _logger.d("No se encontró un registro para la fecha $date.");
  }
}

}
