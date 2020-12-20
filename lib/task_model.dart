import 'db_helper.dart';

class Task {
  String taskName;
  bool isComplete;
  int taskId;
  Task(this.taskName, this.isComplete, [this.taskId]);
  toJson() {
    return {
      DBHelper.taskNameColumnName: this.taskName,
      DBHelper.taskIscompleteColumnName: this.isComplete ? 1 : 0,
      DBHelper.taskIdColumnName: this.taskId
    };
  }

  Task.fromJson(Map map) {
    this.taskId = map[DBHelper.taskIdColumnName];
    this.taskName = map[DBHelper.taskNameColumnName];
    this.isComplete =
        map[DBHelper.taskIscompleteColumnName] == 1 ? true : false;
  }
}
