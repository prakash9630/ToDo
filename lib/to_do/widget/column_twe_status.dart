import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/text_style.dart';
import 'package:todo/const/app_colors.dart';
import 'package:todo/extension/extension.dart';
import 'package:todo/to_do/widget/to_do_tile.dart';
import '../model/task.dart';
import '../provider/to_do_notifier.dart';

class ColumnTwoStatusWidget extends ConsumerWidget {
  const ColumnTwoStatusWidget({Key? key,required this.status,required this.index}) : super(key: key);
  final String status;
  final int index;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tasks = ref.watch(toDoProvider).tasks;
    final provider = ref.watch(toDoProvider);

    // provider.listenToScrollController(index,status);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.appColor
              ),
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: w4f14(AppColors.white),
              ),
            ),
            8.verticalSpace,
            Expanded(
              child: DragTarget<Task>(
                builder: (context, candidateData, rejectedData) {
                  return ListView.builder(
                    controller: provider.scrollControllers[index],
                    itemCount: tasks?.where((task) => task.status == status).length,
                    itemBuilder: (context, index) {
                      final task = tasks?.where((task) => task.status == status).toList()[index];
                      return LongPressDraggable<Task>(
                        data: task,
                        feedback: Material(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              width: 110,
                              decoration: BoxDecoration(
                                  color: AppColors.textGrey,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              child: Text(task!.title,style: w4f14(AppColors.white),)),
                        ),
                        childWhenDragging: Container(),
                        child: ToDoTile(task: task,),
                      );
                    },
                  );
                },
                onAcceptWithDetails: (details) {
                  final Task task = details.data;
                  String? stat=tasks?.firstWhere((t) => t.id == task.id).status = status;
                  provider.updateStatus(task.id,stat!);
                },
              ),
            ),
          ],
        ),
      ),
    );

  }
}
