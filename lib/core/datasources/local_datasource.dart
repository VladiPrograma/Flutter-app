import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();

  static Database? _database;

  LocalDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'my_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(DatabaseQueries._tActuation);
    await db.execute(DatabaseQueries._tComment);
    await db.execute(DatabaseQueries._tMedia);
  }

  Future close() async {
    _database?.close();
  }
}

class DatabaseTables {
  static const String tActuation = "TACTUACION";
  static const String tComment = "TCOMENTARIO_ACTUACION";
  static const String tMedia = "TMEDIA";
}

class DatabaseQueries {
  static const String _tActuation = """
  CREATE TABLE IF NOT EXISTS "TACTUACION" (
	"id_organo"	INTEGER NOT NULL,
	"nombre_organo"	TEXT NOT NULL,
	"id_tipo_organo"	INTEGER NOT NULL,
	"descripcion_tipo_organo"	TEXT NOT NULL,
	"id_procedimiento"	INTEGER NOT NULL,
	"nombre_procedimiento"	TEXT NOT NULL,
	"id_tipo_procedimiento"	INTEGER NOT NULL,
	"descripcion_tipo_procedimiento"	TEXT NOT NULL,
	"id_actuacion"	INTEGER NOT NULL UNIQUE,
	"id_tipo_actuacion"	INTEGER NOT NULL,
	"descripcion_tipo_actuacion"	TEXT NOT NULL,
	"fecha_inicio_actuacion"	TEXT NOT NULL,
	"fecha_fin_actuacion"	TEXT NOT NULL,
	"estado_actuacion"	TEXT NOT NULL,
	"sincronizada"	TEXT NOT NULL,
	PRIMARY KEY("id_actuacion" AUTOINCREMENT)
);
  """;
  static const String _tComment = """
 CREATE TABLE IF NOT EXISTS "TCOMENTARIO_ACTUACION" (
	"id_actuacion"	INTEGER NOT NULL,
	"id_comentario"	INTEGER NOT NULL UNIQUE,
	"fecha"	TEXT NOT NULL,
	"tc"	INTEGER NOT NULL,
	"txt"	TEXT,
	PRIMARY KEY("id_comentario" AUTOINCREMENT)
);
  """;
  static const String _tMedia = """
 CREATE TABLE IF NOT EXISTS "TMEDIA" (
	"id_actuacion"	INTEGER NOT NULL,
	"id_media"	INTEGER NOT NULL UNIQUE,
	"tipo"	TEXT NOT NULL,
	"estado"	INTEGER NOT NULL,
	"ruta"	TEXT NOT NULL,
	"crc"	TEXT NOT NULL,
	"duracion"	INTEGER NOT NULL,
	PRIMARY KEY("id_media" AUTOINCREMENT)
);
  """;
}
