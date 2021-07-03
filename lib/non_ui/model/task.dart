// import 'package:json_annotation/json_annotation.dart';

import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 3)
class Task {
  Task(
      {this.id,
      this.title,
      this.description,
      this.completedAt,
      this.complete,
      this.docId});

  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime completedAt;
  @HiveField(4)
  bool complete;
  @HiveField(5)
  String docId;

  bool get isNew {
    return id == null;
  }

  bool get isCompleted {
    return complete;
  }

  // void toggleComplete() {
  //   if (isCompleted) {
  //     completedAt = null;
  //   } else {
  //     completedAt = DateTime.now();
  //   }
  // }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        completedAt: json["completeAt"],
        complete: json["isCompleted"] ?? false,
        docId: json["docId"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "completeAt": completedAt,
        "isCompleted": complete ?? false
      };
}
