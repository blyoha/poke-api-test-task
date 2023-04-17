import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/poke_model.dart';

class PokeDatabase {
  static final PokeDatabase instance = PokeDatabase._init();
  static Database? _database;

  PokeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("poke.db");
    return _database!;
  }

  _initDB(String dbName) async {
    // Opens the create database
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Creates a schema

    const String sql = '''
    CREATE TABLE IF NOT EXISTS $tablePoke (
      ${PokeFields.id} ${FieldType.id},
      ${PokeFields.name} ${FieldType.text},
      ${PokeFields.height} ${FieldType.integer},
      ${PokeFields.weight} ${FieldType.integer},
      ${PokeFields.abilities} ${FieldType.text},
      ${PokeFields.forms} ${FieldType.text},
      ${PokeFields.image} ${FieldType.text}
    )''';

    await db.execute(sql);
  }

  Future<PokeModel> addPoke(PokeModel poke) async {
    final db = await instance.database;

    await db.insert(tablePoke, poke.toJson());
    return poke;
  }

  Future<PokeModel?> getPoke(String name) async {
    final db = await instance.database;

    final pokes = await db.query(
      tablePoke,
      columns: PokeFields.values,
      where: "${PokeFields.name} = ?",
      whereArgs: [name],
    );

    if (pokes.isNotEmpty) {
      return PokeModel.fromDB(pokes.first);
    } else {
      return null;
    }
  }

  Future close() async {
    // Closes the database
    final db = await instance.database;
    db.close();
  }
}

class FieldType {
  static const id = "INTEGER PRIMARY KEY";
  static const text = "TEXT NOT NULL";
  static const integer = "INTEGER NOT NULL";
}
