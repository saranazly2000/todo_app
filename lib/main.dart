import 'package:flutter/material.dart';
import 'package:todo_app/db_helper.dart';
import 'package:todo_app/new_task_widget.dart';
import 'package:todo_app/task_model.dart';
import 'package:todo_app/task_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TapBar(),
    );
  }
}

class TapBar extends StatefulWidget {
  @override
  _TapBarState createState() => _TapBarState();
}

class _TapBarState extends State<TapBar> {
  List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Todo'),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'All Tasks',
                ),
                Tab(
                  text: 'Complete Tasks',
                ),
                Tab(
                  text: 'InComplete Tasks',
                )
              ],
              isScrollable: true,
            ),
          ),
          body: TabBarView(
              children: [AllTasks(tasks), CompleteTasks(), IncompleteTasks()]),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NewTask();
                },
              ));
            },
          ),
        ));
  }
}

class AllTasks extends StatefulWidget {
  List<Task> tasks;
  AllTasks(this.tasks);

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  deleteTask(e) {
    setState(() {});
    DBHelper.dbHelper.deleteTask(e);
  }

  Widget getTaskWidgets(List<Task> data) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data.length; i++) {
      list.add(TaskWidget(data[i], deleteTask));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBHelper.dbHelper.selectAllTask(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Task> data = snapshot.data;

            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),

      // ),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  deleteTask(e) {
    setState(() {});
    DBHelper.dbHelper.deleteTask(e);
  }

  upFunction() {
    setState(() {});
  }

  Widget getTaskWidgets(List<Task> data) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data.length; i++) {
      list.add(TaskWidget(data[i], deleteTask, upFunction));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBHelper.dbHelper.selectSpecificTask(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Task> data = snapshot.data;
            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),
    );
  }
}

class IncompleteTasks extends StatefulWidget {
  @override
  _IncompleteTasksState createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {
  deleteTask(e) {
    setState(() {});
  }

  upFunction(e) {
    setState(() {});
  }

  Widget getTaskWidgets(List<Task> data) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data.length; i++) {
      list.add(TaskWidget(data[i], deleteTask, upFunction));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBHelper.dbHelper.selectSpecificTask(0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Task> data = snapshot.data;
            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),
    );
  }
}
