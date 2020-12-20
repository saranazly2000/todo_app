import 'package:flutter/material.dart';
import 'package:todo_app/db_helper.dart';
import 'package:todo_app/task_model.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  Function function1;
  Function function2;
  TaskWidget(this.task, [this.function1, this.function2]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shadowColor: Colors.blue,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {});
                    widget.function1(widget.task);
                  }),
              Text(widget.task.taskName),
              Checkbox(
                  value: widget.task.isComplete,
                  onChanged: (value) {
                    DBHelper.dbHelper.updateTask(Task(
                        widget.task.taskName,
                        this.widget.task.isComplete =
                            !this.widget.task.isComplete,
                        widget.task.taskId));
                    setState(() {});
                    widget.function2();
                  })
            ],
          )),
    );
  }
}
