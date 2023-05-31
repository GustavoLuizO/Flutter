import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTbles(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      tipo TEXT,
      valor TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }
  
  static Future<sql.Database> db() async{
    return sql.openDatabase(
      "despesa.db",
      version: 1,
      onCreate: (sql.Database databse, int version) async {
        await createTbles(databse);
      }
    );
  }
  
  static Future<int> creatDate(String tipo, String valor) async{
    final db = await SQLHelper.db();
    
    final data = {"tipo" : tipo, "valor": valor};
    final id = await db.insert('data', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    
    return id;
  }
  
  static Future<List<Map<String, dynamic>>> getAllData({String? searchText}) async {
  final db = await SQLHelper.db();
    if (searchText != null && searchText.isNotEmpty) {
      return db.query(
        'data',
        where: 'tipo LIKE ?',
        whereArgs: ['%$searchText%'],
        orderBy: 'id',
      );
    } else {
      return db.query('data', orderBy: 'id');
    }
  }


  
  static Future<int> updateData(int id, String tipo, String valor) async {
    final db = await SQLHelper.db();
    final data = {
      "tipo" : tipo,
      "valor" : valor,
      'createdAt' : DateTime.now().toString()
    };
    final result = await db.update('data', data, where: "id = ?", whereArgs: [id]);
    
    return result;
  }
  
  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try{
      await db.delete('data', where: "id = ?", whereArgs: [id]);
    }
    catch(e){
      rethrow;
    }
  }
}