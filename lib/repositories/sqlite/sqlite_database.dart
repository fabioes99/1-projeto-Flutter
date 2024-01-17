import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

  Map<int, String> scripts = {
  1: ''' Create table tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao TEXT,
        concluido INTEGER
      );''',
  2: ''' CREATE TABLE imc (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          peso REAL,
          altura REAL,
          data TEXT
  );
 '''
};

class SqliteDatabase{ 

   static Database? db;

  Future<Database> obterDataBase() async {
    if (db == null) {
      return await iniciarBancoDeDados();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarBancoDeDados() async{
  var dbPath = path.join(await getDatabasesPath(), 'database.db');
  var db = await openDatabase(
    dbPath,
    version: scripts.length, 
    onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]);
      }
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async{
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]);
      }
    });
    return db;
}
}