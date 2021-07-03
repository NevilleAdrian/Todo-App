import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/ui/screens/home.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';
import 'package:morphosis_flutter_demo/ui/utils/functions.dart';
import 'package:morphosis_flutter_demo/ui/widgets/future_helper.dart';

class TasksPage extends StatefulWidget {
  TasksPage({@required this.title});

  final String title;

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  FilterHelper filterHelper = FilterHelper();

  void addTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TaskPage(
                title: 'New Task',
              )),
    );
  }

  _delete(Task task) {
    //TODO implement delete to firestore
    setState(() {
      FirebaseManager.fireBaseProvider(context).deleteTask(task, context);
      futureTask =
          FirebaseManager.fireBaseProvider(context).taskManager(context);
    });
  }

  _toggleComplete(Task task) {
    //TODO implement toggle complete to firestore
    setState(() {
      task.complete = !task.complete;
      FirebaseManager.fireBaseProvider(context).updateTask(task, context);
      futureTask =
          FirebaseManager.fireBaseProvider(context).taskManager(context);
    });
  }

  Future<List<Task>> futureTask;

  @override
  void initState() {
    futureTask = filterHelper.futureFirebaseTask(context);
    super.initState();
  }

  Widget taskManager() {
    print(FirebaseManager.fireBaseProvider(context).task);
    List<Task> task = FirebaseManager.fireBaseProvider(context).task ?? [];
    List<Task> completedTask =
        task.where((element) => element.complete).toList();
    return task == null || completedTask == null || task.length == 0
        ? CircularProgress()
        : ListView.builder(
            itemCount: widget.title == 'Completed Tasks'
                ? completedTask.length
                : task.length,
            itemBuilder: (context, index) {
              return _Task(
                widget.title == 'Completed Tasks'
                    ? completedTask[index]
                    : task[index],
                onDelete: _delete,
                onUpdate: _toggleComplete,
                id: FirebaseManager.fireBaseProvider(context).task[index].docId,
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addTask(context),
          )
        ],
      ),
      body: FutureHelper<List<Task>>(
        task: futureTask,
        loader: taskManager(),
        noData: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Add your first task'),
            )
          ],
        ),
        builder: (context, _) => taskManager(),
      ),
    );
  }
}

class _Task extends StatelessWidget {
  _Task(this.task, {this.onDelete, this.onUpdate, this.id});

  final Task task;
  final Function onDelete;
  final Function onUpdate;
  final String id;

  void _view(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              TaskPage(task: task, title: 'Edit Task', docId: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          task.complete ?? false
              ? Icons.check_box
              : Icons.check_box_outline_blank,
        ),
        onPressed: () => onUpdate(task),
      ),
      title: Text(
        task.title ?? '',
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(task.description ?? ''),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
        ),
        onPressed: () => onDelete(task),
      ),
      onTap: () => _view(context),
    );
  }
}
