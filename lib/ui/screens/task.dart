import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/ui/screens/index.dart';

class TaskPage extends StatelessWidget {
  TaskPage({this.task, this.title, this.docId});

  final Task task;
  final String title, docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _TaskForm(task, title, docId),
    );
  }
}

class _TaskForm extends StatefulWidget {
  _TaskForm(this.task, this.title, this.docId);

  final Task task;
  final String title, docId;

  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  __TaskFormState(this.task);

  Task task;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  bool isToggle = false;
  Future<List<Task>> futureTask;

  void init() {
    if (task == null) {
      task = Task();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      task = Task(
          title: task.title,
          description: task.description,
          complete: task.complete);
      _titleController = TextEditingController(text: task.title);
      _descriptionController = TextEditingController(text: task.description);
    }
  }

  void _toggleComplete() {
    setState(() {
      isToggle = !isToggle;
      task.complete = isToggle;
      FirebaseManager.fireBaseProvider(context).updateTask(task, context);
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context, Task task) {
    //TODO implement save to firestore
    task.title = _titleController.text;
    task.description = _descriptionController.text;
    task.docId = widget.docId;

    if (widget.title == 'Edit Task') {
      setState(() {
        FirebaseManager.fireBaseProvider(context).updateTask(task, context);
      });
    } else {
      setState(() {
        FirebaseManager.fireBaseProvider(context).addTask(task, context);
      });
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IndexPage(
                  index: 1,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: _padding),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              minLines: 5,
              maxLines: 10,
            ),
            SizedBox(height: _padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed ?'),
                CupertinoSwitch(
                  value: task.complete ?? false,
                  onChanged: (_) {
                    _toggleComplete();
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _save(context, task);
                });
              },
              child: Container(
                width: double.infinity,
                child: Center(
                    child: Text(
                        widget.title == 'Edit Task' ? 'Update' : 'Create')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
