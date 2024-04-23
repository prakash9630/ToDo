
import 'package:flutter/material.dart';
import 'package:todo/to_do/model/task.dart';

showDeleteDialogue(BuildContext context,{required Task task,required Function(BuildContext) onApproved}){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: Text('Are your sure you Want to delete ${task.title}'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('cancel'),
          ),
          TextButton(
            onPressed: (){
              onApproved(context);
            },
            child: const Text('ok'),
          ),
        ],
      );
    },
  );
}

