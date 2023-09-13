import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  // updating the task
  void _updateTask(BuildContext context, Task task) {
    context.read<TasksBloc>().add(UpdateTask(task: task));
  }

  // deleting the task
  // void _deleteTask(BuildContext context, Task task) {
  //   context.read<TasksBloc>().add(DeleteTask(task: task));
  // }

  // method to remove or delete task
  void _deleteOrRemoveTask(BuildContext context, Task task) {
    if (task.isDeleted!) {
      context.read<TasksBloc>().add(DeleteTask(task: task));
    } else {
      context.read<TasksBloc>().add(RemoveTask(task: task));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.task.title,
        style: TextStyle(
          decoration: widget.task.isDone!
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: Checkbox(
        value: widget.task.isDone,
        activeColor: widget.task.isDeleted! ? Colors.grey : Colors.blue,
        onChanged: (_) =>
            widget.task.isDeleted! ? null : _updateTask(context, widget.task),
      ),
      onLongPress: () => _deleteOrRemoveTask(context, widget.task),
    );
  }
}
