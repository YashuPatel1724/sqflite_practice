import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future get database async => _db ?? await initDatabase();
// Future getDatabase()
// async {
//   if(_db!=null)
//     {
//       return _db;
//     }
//   else
//     {
//       return await initDatabase();
//     }
// }
  // database create table
  Future initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'finace.db');

    _db = await openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      String sql = '''CREATE TABLE finace(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL NOT NULL,
      isIncome INTEGER NOT NULL,
      category TEXT);
      ''';
      await db.execute(sql);
    },);
    return _db;
  }

  Future insertData(double amount,int isIncome,String category)
  async {
    Database? db = await database;
    String sql = '''INSERT INTO finace (amount,isIncome,category)
    VALUES (?,?,?);
    ''';
    List args= [amount,isIncome,category];
    await db!.rawInsert(sql,args);
  }

  Future<List<Map>> readData()
  async {
    Database? db = await database;
    String sql = '''SELECT * FROM finace''';
    return await db!.rawQuery(sql);
  }

  Future<void> removeData(int id)
  async {
    Database? db = await database;
    String sql = '''DELETE FROM finace WHERE id = ?''';
    List args = [id];
    await db!.rawDelete(sql,args);
  }

  Future<void> updateData(double amount, int isIncome, String category,int id)
  async {
    Database? db = await database;
    String sql = '''UPDATE finace SET amount = ?, isIncome = ?, category = ? WHERE id = ?''';
    List args = [amount,isIncome,category,id];
    await db!.rawUpdate(sql,args);
  }
}