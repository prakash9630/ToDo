import 'dart:convert';
import 'package:flutter/animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/to_do/model/task.dart';
import '../services/service_locator.dart';

void storeString(String key, String value) {
  getIt<SharedPreferences>().setString(key, value);
}

String? getString(String key) {
  return getIt<SharedPreferences>().getString(key);
}

void storeBool(String key, bool value) {
  getIt<SharedPreferences>().setBool(key, value);
}

bool? getBool(String key) {
  return getIt<SharedPreferences>().getBool(key);
}

void removeKey(String key) {
  getIt<SharedPreferences>().remove(key);
}

void storeList(String key,List<Task> value) {
  String data = jsonEncode(value.map((task) => task.toJson()).toList());
  storeString(key, data);
}
List<Task>? getTaskList({required String key,
}) {
  try {
     List<Task> taskAdded=[];
    List<Task> decodedTasks = (jsonDecode(getString(key)!) as List<dynamic>)
        .map((taskJson) => Task.fromJson(taskJson as Map<String, dynamic>))
        .toList();
    // Check if it works
    for (var task in decodedTasks) {
      taskAdded.add(task);
    }
    return taskAdded;

  } catch (error) {
    return null;
  }
}