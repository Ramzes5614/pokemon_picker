import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_project/models/model_for_db.dart';
import 'package:test_project/models/pokemon_model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _db;
  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "TestDB.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Querries ("
          "id INTEGER PRIMARY KEY UNIQUE,"
          "name TEXT,"
          "image TEXT"
          ")");
    });
  }

  newQuerry(ModelForDB pokemon) async {
    final db = await database;
    var check = await db.rawQuery(
        "SELECT COUNT(1)"
        " FROM Querries "
        " WHERE id = (?)",
        [pokemon.id]);
    if (check.first.values.first != 0) {
      return;
    }
    var res = await db.rawInsert(
      "INSERT Into Querries (id, name, image)"
      " VALUES (?, ?, ?)",
      [pokemon.id, pokemon.name, pokemon.image],
    );
    return res;
  }

  getAllClients() async {
    final db = await database;
    var res = await db.query("Querries");
    List<ModelForDB> list =
        res.isNotEmpty ? res.map((c) => ModelForDB.fromMap(c)).toList() : [];
    return list;
  }
}
