import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';

class SQLStudyAreas {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'favStudySpots.db'),
        onCreate: (db, version) {
      return db
          .execute('CREATE TABLE favs_study_areas(title TEXT PRIMARY KEY)');
    }, version: 1);
  }

  static Future<int> makeFav(String table, Map<String, Object> data) async {
    final db = await SQLStudyAreas.database();
    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final db = await SQLStudyAreas.database();
    return db.query(table, columns: ['title']);
  }

  static Future<int> removeFav(String table, String name) async {
    final db = await SQLStudyAreas.database();
    // return await db.rawDelete("DELETE FROM $table WHERE title = $name");
    return await db.delete(table, where: 'title = ?', whereArgs: ['$name']);
    // db.delete(table);
  }
}