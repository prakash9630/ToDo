import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/components/custom__calender_date_picker.dart';
import 'package:todo/components/custom_button.dart';
import 'package:todo/components/customtextfield.dart';
import 'package:todo/const/app_colors.dart';
import 'package:todo/extension/extension.dart';
import 'package:uuid/uuid.dart';
import '../../common/text_style.dart';
import '../model/task.dart';
import '../provider/to_do_notifier.dart';


showAddTaskDialog(BuildContext context, {Task? task, Function(BuildContext ctx)? onCallBack}) {
  showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(
          task: task,
          onCallBack: onCallBack,
        );
      });
}

class AddTaskDialog extends ConsumerStatefulWidget {
  const AddTaskDialog({Key? key, this.task, this.onCallBack}) : super(key: key);
  final Task? task;
  final Function(BuildContext ctx)? onCallBack;

  @override
  ConsumerState<AddTaskDialog> createState() => _AddTaskDState();
}

class _AddTaskDState extends ConsumerState<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _dateController.text = widget.task!.dueDate;
      _desController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.read(toDoProvider);

    return Dialog(
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        "Add Task",
                        style: w6f20(AppColors.textBlack),
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close,color: AppColors.appColor,))
                    ],
                  ),
                ),
                20.verticalSpace,
                CustomTextField(
                  labelText: "",
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Title is required";
                    }
                  },
                  controller: _titleController,
                  hintText: "Title",
                ),
                10.verticalSpace,
                CustomCalenderDatePicker(
                  dateCon: _dateController,
                  labelText: "",
                  hintText: "submission date",
                  showRequired: true,
                  validator:(v){
                    if(v!.isNotEmpty && DateTime.parse(v).isBefore(DateTime.now())){
                         return "Date should not be in past";
                    }
                  } ,
                ),
                10.verticalSpace,
                CustomTextField(
                  labelText: "",
                  controller: _desController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Please add your task.";
                    }
                  },
                  maxLines: 8,
                  hintText: "To do text",
                ),
                10.verticalSpace,
                CustomButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        if (widget.task == null) {
                          var uuid = const Uuid();
                          tasks.addToDoList(Task(
                              id: uuid.v1(),
                              title: _titleController.text,
                              dueDate: _dateController.text,
                              description: _desController.text));
                        } else {
                          tasks.updateTask(Task(
                            id: widget.task!.id,
                            title: _titleController.text,
                            dueDate: _dateController.text,
                            description: _desController.text,
                          ));
                        }
                            if(widget.onCallBack!=null){
                              widget.onCallBack!(context);
                            }else{
                              Navigator.pop(context);
                            }
                      }
                    },
                    label: widget.task != null ? "Update" : "Add")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
