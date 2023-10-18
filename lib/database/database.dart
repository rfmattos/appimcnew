import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: '''
CREATE TABLE imcs (
id INTEGER PRIMARY KEY AUTOINCREMENT,
peso DOUBLE,
datahorapesado TEXT
);
'''
};

class SQLiteDataBae {
  static Database? db;

  Future<Database> obterDataBase() async {
    if (db == null) {
      return await iniciarBancoDados();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarBancoDados() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        print(scripts[i]);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = 1; oldVersion + 1 <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        print(scripts[i]);
      }
    });
    return db;
  }
}
