import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/extension/extension.dart';

import '../model/task.dart';
import '../provider/to_do_notifier.dart';

class ColumnStatusWidget extends ConsumerWidget {
  const ColumnStatusWidget({Key? key,required this.status}) : super(key: key);
 final String status;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tasks = ref.watch(toDoProvider).tasks;
    final provider = ref.watch(toDoProvider);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
           8.verticalSpace,
            Expanded(
              child: DragTarget<Task>(
                builder: (context, candidateData, rejectedData) {
                  return ListView.builder(
                    itemCount: tasks?.where((task) => task.status == status).length,
                    itemBuilder: (context, index) {
                      final task = tasks?.where((task) => task.status == status).toList()[index];
                      return Draggable<Task>(
                        data: task,
                        feedback: Material(child: Text(task!.title)),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          padding: EdgeInsets.all(8.0),
                          color: Colors.white,
                          child: Text(task.title),
                        ),
                        childWhenDragging: Container(),
                      );
                    },
                  );
                },
                onAccept: (task) {
                    tasks?.firstWhere((t) => t.id == task.id).status = status;
                  provider.notifyListeners();
                },
              ),
            ),
          ],
        ),
      ),
    );

  }
}
