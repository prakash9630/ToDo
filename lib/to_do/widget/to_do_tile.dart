import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/const/app_colors.dart';
import 'package:todo/to_do/model/task.dart';
import 'package:todo/to_do/widget/show_task_add_dialogue.dart';
import 'package:todo/to_do/widget/task_detail_widget.dart';
import '../../common/text_style.dart';
import '../provider/to_do_notifier.dart';
import '../screen/status_widget.dart';
import 'delete_alert.dart';

class ToDoTile extends ConsumerWidget {
  const ToDoTile(
      {super.key,required this.task});
  final Task task;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tasks = ref.read(toDoProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.textGrey,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(onTap:(){
            showTaskDetailDialogue(context, task: task,);
          },child: Text(task.title,style: w4f14(AppColors.white),)),
        ),
      ),
    );
    }
}
