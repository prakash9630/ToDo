
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/storage/shared_preferences.dart';
import 'package:todo/to_do/model/task.dart';
import '../../const/app_string.dart';
import '../../storage/shared_key.dart';

final toDoProvider = ChangeNotifierProvider<ToDoNotifier>((ref) => ToDoNotifier());

class ToDoNotifier extends ChangeNotifier{
  List<Task>? tasks=getTaskList(key: SharedKey.task)??[];
  List<String> status = [
    AppString.uncompleted,
    AppString.inProcess,
    AppString.completed
  ];
  List<ScrollController> scrollControllers = List.generate(3, (index) => ScrollController());
  bool isLoading = false;


  void listenToScrollController(int index,String status) {
    scrollControllers[index].addListener(() {
      if (scrollControllers[index].position.pixels == scrollControllers[index].position.maxScrollExtent && !isLoading) {
        loadMoreTasks(status) ;      }
    });
  }

  void loadMoreTasks(String status) {

    // Simulate a network load with a delay
    Future.delayed(const Duration(seconds: 1), () {
      List<Task>? lazyLoadTask= List.generate(10, (index) => tasks![index]);
      notifyListeners();
    });
  }



  addToDoList(Task todo){
    tasks?.add(todo);
    storeList(SharedKey.task, tasks!);
    notifyListeners();
  }

  void updateStatus(String id, String newStatus) {
    tasks?.firstWhere((task) => task.id == id).status = newStatus;
    storeList(SharedKey.task, tasks!);
    notifyListeners();
  }



  void updateTask(Task upDateTask) {
     int index = tasks!.indexWhere((todo) => todo.id == upDateTask.id);
    if (index != -1) {
      tasks![index].title = upDateTask.title;
      tasks![index].dueDate = upDateTask.dueDate;
      tasks![index].description = upDateTask.description;
    }
    storeList(SharedKey.task, tasks!);
    notifyListeners();
  }

  void deleteTask(String id,) {
    tasks?.removeWhere((task) => task.id == id);
    storeList(SharedKey.task, tasks!);
    notifyListeners();
  }

  void rebuildState({required oldIndex,required int newIndex}){
    final Task item= tasks!.removeAt(oldIndex);
    tasks?.insert(newIndex, item);
    storeList(SharedKey.task, tasks!);
    notifyListeners();
  }

  void refresh(){
    notifyListeners();
  }


}