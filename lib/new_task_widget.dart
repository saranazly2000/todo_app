import 'package:flutter/material.dart';
import 'package:todo_app/db_helper.dart';
import 'package:todo_app/task_model.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  int taskId;
  String taskName;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (value) {
                this.taskName = value;
              },
            ),
            Checkbox(
              value: isComplete,
              onChanged: (value) {
                this.isComplete = value;
                setState(() {});
              },
            ),
            RaisedButton(
                child: Text('Add New Task'),
                onPressed: () {
                  DBHelper.dbHelper.insertNewTask(
                      Task(this.taskName, this.isComplete, this.taskId));
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
