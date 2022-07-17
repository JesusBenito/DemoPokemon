import 'dart:io';


import 'package:path/path.dart';
import 'package:pokemon/View/User/components/drag_select_grid.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class PokedexDatabase{
  static String? path;
  static final _databaseName = "pokemonDB.db";
  static final _databaseVersion = 1;


  PokedexDatabase._privateConstructor();
  static final PokedexDatabase instance = PokedexDatabase._privateConstructor();
  
  static Database? _database;


  Future get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS pokedex(idPokedex INTEGER PRIMARY KEY autoincrement, name TEXT)",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS pokemons(idPokemons INTEGER PRIMARY KEY autoincrement, idPokedex INTEGER,idPokemon INTEGER)",
    );
  }


  static Future getFileData() async {
    return getDatabasesPath().then((s){
      return path=s;
    });
  }



  Future insertPokedex(String name) async {
    Database db = await instance.database;
    return  await db.rawQuery("INSERT INTO pokedex(name) VALUES ('$name')");
  }

  Future insertPokemon(int idPokemon,int idPokedex) async {
    Database db = await instance.database;
    return  await db.rawQuery("INSERT INTO pokemons(idPokedex,idPokemon) VALUES ('$idPokedex','$idPokemon')");
  }

  Future getPokedex() async {
    Database db = await instance.database;
    var res = await  db.rawQuery("SELECT pok.name as namePokedex, poks.idPokemon from pokedex pok, pokemons poks WHERE poks.idPokedex = pok.idPokedex group by poks.idPokedex");
    return res.toList();
  }

  Future getIdPokedex() async {
    Database db = await instance.database;
    var res = await  db.rawQuery("SELECT MAX(idPokedex) AS id FROM pokedex");
    return res.toList();
  }

  Future getPokemons(int idPokedex) async {
    Database db = await instance.database;
    var res = await  db.rawQuery("select * from pokemons where idPokedex = '$idPokedex'");
    return res.toList();
  }

  Future getPokedexs() async {
    Database db = await instance.database;
    var res = await  db.rawQuery("select * from pokedex");
    return res.toList();
  }

}