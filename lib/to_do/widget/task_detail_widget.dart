import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/to_do/screen/status_widget.dart';
import 'package:todo/to_do/widget/show_task_add_dialogue.dart';

import '../../common/text_style.dart';
import '../../components/custom_button.dart';
import '../../const/app_colors.dart';
import '../model/task.dart';
import '../provider/to_do_notifier.dart';
import 'delete_alert.dart';

showTaskDetailDialogue(BuildContext context, {required Task task}) {
  showDialog(
      context: context,
      builder: (context) {
        return TaskDetailDialog(
          task: task,
        );
      });
}

class TaskDetailDialog extends ConsumerWidget {
  const TaskDetailDialog({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.read(toDoProvider);

    return Dialog(
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Task Detail",
                    style: w6f20(AppColors.textBlack),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close))
                ],
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: w5f16(AppColors.textBlack),
                  ),
                ),
                StatusWidget(status: task.status,)
              ],
            ),
            5.verticalSpace,
            Text(
              "Due Date: ${task.dueDate}",
              style: w4f14(AppColors.textBlack),
            ),
            10.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task",
                  style: w4f13(AppColors.textGrey),
                ),
                Text(
                  task.description,
                  style: w4f14(AppColors.textBlack),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      showAddTaskDialog(context, task: task,onCallBack: (ctx){
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                      });
                    },
                    child: const Icon(Icons.edit, color: AppColors.appColor,)),
                15.horizontalSpace,
                InkWell(
                    onTap: () {
                      showDeleteDialogue(
                          context, task: task, onApproved: (ctx) {
                        tasks.deleteTask(task.id);
                        Navigator.pop(ctx);
                        Navigator.pop(context);

                      });
                    },
                    child: const Icon(Icons.delete, color: AppColors.red,)),

              ],),
            30.verticalSpace,
            CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: "Ok")
          ],
        ),
      ),
    );
  }
}

