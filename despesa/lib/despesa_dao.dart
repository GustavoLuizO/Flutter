import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import 'despesa.dart';

class DespesaDAO {
  Future<Database> _getDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactory;

    final String path = await getDatabasesPath();
    final String databasePath = join(path, 'despesas.db');

    return openDatabase(
      databasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE despesas(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor REAL
          )
        ''');
      },
    );
  }


  Future<void> inserirDespesa(Despesa despesa) async {
    final Database db = await _getDatabase();
    await db.insert(
      'despesas',
      despesa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Despesa>> consultarDespesas() async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('despesas');

    return List.generate(maps.length, (index) {
      return Despesa.fromMap(maps[index]);
    });
  }

  Future<double> consultarTotalDespesas() async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('despesas');

    double total = 0;
    for (var map in maps) {
      total += map['valor'] as double;
    }

    return total;
  }

  Future<double> consultarTotalDespesasPorTipo(String tipo) async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'despesas',
      where: 'tipo = ?',
      whereArgs: [tipo],
    );

    double total = 0;
    for (var map in maps) {
      total += map['valor'] as double;
    }

    return total;
  }
}
