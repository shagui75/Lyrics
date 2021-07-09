import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lyric_search/models/LyricSearch_model.dart';

class DbClass {
  Future<Database> database;
  String pathBD;

  DbClass() {
    openDB();
  }

  void openDB() async {
    database = openDatabase(
      // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
      // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
      // construida para cada plataforma.

      join(await getDatabasesPath(), 'lyrics_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE searches(id INTEGER PRIMARY KEY, title TEXT, artist TEXT)",
        );
      },
      // Establece la versión. Esto ejecuta la función onCreate y proporciona una
      // ruta para realizar actualizacones y defradaciones en la base de datos.
      version: 1,
    );
  }

  Future<void> insertSearch(LyricSearch actualSearch) async {
    // Obtiene una referencia de la base de datos
    final Database db = await database;

    // `conflictAlgorithm` reemplaza cualquier dato anterior en caso de que el mismo "actualSearch" se inserte dos veces.
    await db.insert(
      'searches',
      actualSearch.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //obtiene el listado de todas las búsquedas
  Future<List<LyricSearch>> getSearches() async {
    // Obtiene una referencia de la base de datos
    final Database db = await database;
    if (db == null) {
      openDB();
    }
    // Consulta la tabla por todos las búsquedas.
    final List<Map<String, dynamic>> maps = await db.query('searches');
    // Convierte List<Map<String, dynamic> en List<LyricSearch>.
    return List.generate(maps.length, (i) {
      //invierto el indice para mostrar primkero las últimas búsquedas
      int index = maps.length - 1 - i;
      return LyricSearch(
        id: maps[index]['id'],
        title: maps[index]['title'],
        artist: maps[index]['artist'],
      );
    });
  }

  Future<int> getNextID() async {
    final Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM searches'));
  }
}
