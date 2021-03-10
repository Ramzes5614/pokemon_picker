import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
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
      ///По идее, для того, чтобы не конвертировать abilities в json, можно создать три таблицы
      ///1 - Querries
      ///2 - Abilities
      ///3 - Смежная таблица QuerryAbilities, состоящая из внешних ключей, для того чтобы связать
      ///первые две таблицы
      await db.execute("CREATE TABLE Querries ("
          "id INTEGER PRIMARY KEY UNIQUE,"
          "name TEXT,"
          "image TEXT, "
          "abilities TEXT "
          ")");
        
    });
  }

  getPokemonByName(String name) async {
    final db = await database;
    var check = await db.rawQuery(
        "SELECT COUNT(1)"
        " FROM Querries "
        " WHERE name = (?)",
        [name]);
    print(check);
    if (check.first.values.first == 0) {
      return null;
    }
    check = await db.rawQuery(
        "SELECT *"
        " FROM Querries "
        " WHERE name = (?)",
        [name]);
    return PokemonModel.fromDB(check.first);
  }

  getPokemonById(int id) async {
    final db = await database;
    var check = await db.rawQuery(
        "SELECT COUNT(1)"
        " FROM Querries "
        " WHERE id = (?)",
        [id]);
    print(check);
    if (check.first.values.first == 0) {
      return null;
    }
    check = await db.rawQuery(
        "SELECT *"
        " FROM Querries "
        " WHERE id = (?)",
        [id]);
    return PokemonModel.fromDB(check.first);
  }

  addPokemon(PokemonModel pokemon) async {
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
      "INSERT Into Querries (id, name, image, abilities)"
      " VALUES (?, ?, ?, ?)",
      [pokemon.id, pokemon.name, pokemon.image, json.encode(pokemon.abilitiesToJson())],
    );
    return res;
  }

  getAllClients() async {
    final db = await database;
    var res = await db.query("Querries");
    List<PokemonModel> list =
        res.isNotEmpty ? res.map((c) => PokemonModel.fromDB(c)).toList() : [];
    return list;
  }
}
