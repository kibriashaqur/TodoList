import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'list.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    //creating table in the databse

    await db.execute(
        "CREATE TABLE mytodo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, dateandtime TEXT NOT NULL)");
  }

  //data inserting
  Future<TodoList> insert(TodoList todoList) async {
    var dbClint = await db;
    await dbClint?.insert('mytodo', todoList.toMap());
    return todoList;
  }

  Future<List<TodoList>> getDataList() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
    await _db!.rawQuery('SELECT * FROM mytodo');
    return QueryResult.map((e) => TodoList.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClint = await db;
    return await dbClint!.delete('mytodo', where: 'id?', whereArgs: [id]);
  }

  Future<int> update(TodoList todoList) async {
    var dbClint = await db;
    return await dbClint!.update('mytodo', todoList.toMap(),
        where: 'id?', whereArgs: [todoList.id]);
  }
}
