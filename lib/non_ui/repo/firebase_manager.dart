import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/hive/hive_repository.dart';
import 'package:morphosis_flutter_demo/ui/utils/constants.dart';
import 'package:morphosis_flutter_demo/ui/widgets/dialogs.dart';
import 'package:provider/provider.dart';

class FirebaseManager extends ChangeNotifier {
  HiveRepository _hiveRepository = HiveRepository();

  List<Task> _task;

  List<Task> get task => _task;

  setTasks(List<Task> task) {
    _task = task;
    notifyListeners();
  }

  static BuildContext _context;

  static FirebaseManager fireBaseProvider(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<FirebaseManager>(context, listen: listen);
  }

  //TODO: change collection name to something unique or your name
  CollectionReference get tasksRef =>
      FirebaseFirestore.instance.collection('todo');

  //TODO: replace mock data. Remember to set the task id to the firebase object id

  Future<List<Task>> taskManager(BuildContext context) async {
    QuerySnapshot querySnapshot = await tasksRef.get();

    List<Task> result = querySnapshot.docs.map((t) {
      return Task.fromJson({...t.data() as Map, 'docId': t.id});
    }).toList();

    //Set data to list of Tasks
    print('tasksss: $result');
    setTasks(result);
    notifyListeners();

    //Save data in hive
    _hiveRepository.add<List<Task>>(name: kTasks, key: 'tasks', item: result);

    return Future.value(result);
  }

  //TODO: implement firestore CRUD functions here
  void addTask(Task task, BuildContext context) async {
    tasksRef.add(task.toJson());
    await taskManager(context);
    notifyListeners();
    showFlush(
      context,
      'Succesfully Added Task',
    );
  }

  void deleteTask(Task task, BuildContext context) async {
    try {
      await tasksRef.doc(task.docId).delete();
      List<Task> tasksRemainingAfterDelete =
          _task.where((element) => element.docId != task.docId).toList();
      setTasks(tasksRemainingAfterDelete);
      notifyListeners();
      showFlush(
        context,
        'Succesfully Deleted Task',
      );
    } catch (ex) {
      print('ex:$ex');
    }
  }

  void updateTask(Task task, BuildContext context) async {
    try {
      await tasksRef.doc(task.docId).update(task.toJson());
      List<Task> tasksRemainingAfterUpdate = _task
          .map((element) => element.docId == task.docId ? task : element)
          .toList();
      setTasks(tasksRemainingAfterUpdate);
      _hiveRepository.add<List<Task>>(
          name: kTasks, key: 'tasks', item: tasksRemainingAfterUpdate);
      notifyListeners();
      showFlush(
        context,
        'Succesfully Updated Task',
      );
    } catch (ex) {}
  }
}
