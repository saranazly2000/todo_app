import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/task_model.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static final String databaseName = 'tasksDb.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIscompleteColumnName = 'isComplete';
  Database database;
  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);
      Database database =
          await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
          $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $taskNameColumnName TEXT NOT NULL,
          $taskIscompleteColumnName INTEGER
        )''');
      });
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    try {
      database = await initDatabase();
      int x = await database.insert(tableName, task.toJson());
      print(x);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task>> selectAllTask() async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName);
      print(result);
      List<Task> tasks = result.map((e) => Task.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task>> selectSpecificTask(int isComplete) async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName,
          where: '$taskIscompleteColumnName=?', whereArgs: [isComplete]);
      print(result);
      List<Task> tasks = result.map((e) => Task.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.update(tableName, task.toJson(),
          where: '$taskIdColumnName=?', whereArgs: [task.taskId]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.delete(tableName,
          where: '$taskIdColumnName=?', whereArgs: [task.taskId]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }
}
