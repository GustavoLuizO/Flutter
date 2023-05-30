import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

const String contactTable = "contactTable"; 
const String idColumn = "idColumn";
const String nameColumn = "nameColumn";
const String emailColumn = "emailColumn";
const String phoneColumn = "phoneColumn";

class Contact {
  late int Id;
  late String Name;
  late String Email;
  late String Phone;
  
  Contact();
  
  Contact.fromMap(Map map) {
    Id = map[idColumn];
    Name = map[nameColumn];
    Email = map[emailColumn];
    Phone = map[phoneColumn];
  }
  
  Map<String, dynamic> toMap() {
    return {
      nameColumn: Name,
      emailColumn: Email,
      phoneColumn: Phone,
    };
  }
}

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider.internal(); 
  factory DatabaseProvider() => _instance; 
  DatabaseProvider.internal();
  
  Future<Database> initDb() async {
    final dataBasesPath = await getDatabasesPath(); 
    final path = join(dataBasesPath, "contactsnew.db");

    return await openDatabase(path, version: 1, 
      onCreate: (Database db, int newerVersion) async {
        await db
          .execute("CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY," 
            "$nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT)");
      });
  }
  
  Future<Contact> saveContact (Contact contact) async {
    //TODOIs initDb correct or db?
    Database dbContact = await initDb();
    contact.Id = await dbContact.insert(contactTable, contact.toMap()); return contact;
  }
  
  Future<Contact> getContact (int id) async {
    //TODOIs initDb correct or db?
    Database dbContact = (await getDatabasesPath()) as Database;
    List<Map> maps = await dbContact.query(contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn], 
      where: "$idColumn = ?",
      whereArgs: [id]);
    
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    }
    
    return Contact();
  }
  
  Future<int> updateContact (Contact contact) async {
    //TODOIs initDb correct or db?
    Database dbContact = await initDb();
    return await dbContact.update (
      contactTable, contact.toMap(), 
      where: "$idColumn = ?", whereArgs: [contact.Id]
    );
  }
  
  Future<List<Contact>> getAllContacts() async {
    //TODOIs initDb correct or db?
    Database dbContact = await initDb();
    List listMap = await dbContact.rawQuery("SELECT * FROM contactTable"); 
    List<Contact> listContact = [];
    
    for (Map m in listMap) {
      listContact.add(Contact.fromMap (m));
    }
    
    return listContact;
  }
}