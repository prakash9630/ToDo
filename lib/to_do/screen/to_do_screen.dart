import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/text_style.dart';
import 'package:todo/const/app_asset.dart';
import 'package:todo/const/app_colors.dart';
import 'package:todo/const/app_string.dart';
import 'package:todo/extension/extension.dart';
import '../model/task.dart';
import '../provider/to_do_notifier.dart';
import '../widget/column_twe_status.dart';
import '../widget/show_task_add_dialogue.dart';

class ToDoScreen extends ConsumerWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(toDoProvider).tasks;
    final provider = ref.watch(toDoProvider);


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ToDo List',
          style: TextStyle(color: AppColors.white),
        ),
        // backgroundColor: AppColors.appColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.appColor,
        onPressed: () {
          showAddTaskDialog(context);

        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: tasks!.isNotEmpty
          ? Row(
            children: provider.status.asMap().entries.map((entry) {
              return ColumnTwoStatusWidget(status: entry.value, index: entry.key);
            }).toList(),
          )
          : Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAsset.emptyList),
                10.verticalSpace,
                Text(
                  "ToDo list is empty.",
                  style: w5f16(AppColors.black),
                )
              ],
            )),
    );
  }
}
