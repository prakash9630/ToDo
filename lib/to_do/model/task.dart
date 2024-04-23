import 'package:todo/const/app_string.dart';
import 'package:todo/enum/task_enum.dart';

class Task {
  String id;
  String title;
  String description;
  String dueDate;
  String status;

  Task({required this.id, required this.title, required this.dueDate, this.status =AppString.uncompleted,this.description=""});

  // Factory constructor for creating a new Task instance from a map.
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
      status: json['status'],
    );
  }

  // Convert a Task instance to a map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      "description": description,
      'dueDate': dueDate,
      'status': status,
    };
  }
}
