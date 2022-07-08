import 'package:firebase_todo/model/task.dart';
import 'package:firebase_todo/provider/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatelessWidget {
  Task task;
  TodoItem({required this.task});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    return Card(
      elevation: 1,
      color: Colors.white,
      child: ListTile(
        onTap: ()=> formProvider.updatePage(context, task),
        title: Text(task.name!),
        subtitle: Text(task.description!),
        trailing: IconButton(
          onPressed: ()=>formProvider.deleteTask(task), 
          icon: const Icon(Icons.delete, color: Colors.orange)
        ),
      ),
    );
  }
}