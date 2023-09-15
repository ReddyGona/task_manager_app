import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/widgets/edit_task_bottom_sheet.dart';
import 'package:flutter_tasks_app/widgets/task_options_menu.dart';
import 'package:intl/intl.dart';

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

  // method to like or dislike a task
  void _likeOrDislikeTask(BuildContext context, Task task) {
    context.read<TasksBloc>().add(MarkFavouriteOrUnfavouriteTask(task: task));
  }

  // method to restore the task
  void _restoreTask(BuildContext context, Task task) {
    context.read<TasksBloc>().add(RestoreTask(task: task));
  }

// method to edit the task
  void _editTask(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: EditTaskBottomSheet(currentTask: widget.task),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLeadingIconAndTitleUI(),
          _buildTrailingIcons(context),
        ],
      ),
    );
  }

  Expanded _buildLeadingIconAndTitleUI() {
    return Expanded(
      child: Row(
        children: [
          // Icon for marking the task as favourite
          widget.task.isFavourite == false
              ? const Icon(Icons.star_border_outlined)
              : const Icon(Icons.star),
          const SizedBox(width: 10.0),
          _buildTitleAndSubTitleUI(),
        ],
      ),
    );
  }

  Expanded _buildTitleAndSubTitleUI() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
              decoration: widget.task.isDone!
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          // getting the date and time when the task was created

          // using the DateFormat() and the inbuilt methods to format the date time
          Text(
            DateFormat()
                .add_yMMMd()
                .add_Hms()
                .format(DateTime.parse(widget.task.createdAt)),
          ),
        ],
      ),
    );
  }

  Row _buildTrailingIcons(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.task.isDone,
          activeColor: widget.task.isDeleted! ? Colors.grey : Colors.blue,
          onChanged: (_) =>
              widget.task.isDeleted! ? null : _updateTask(context, widget.task),
        ),
        TaskOptionsMenuUI(
          task: widget.task,
          cancelOrDeleteTaskCallback: () =>
              _deleteOrRemoveTask(context, widget.task),
          likeOrDislikeTaskCallback: () =>
              _likeOrDislikeTask(context, widget.task),
          editTaskCallback: () => _editTask(context),
          restoreTaskCallback: () => _restoreTask(context, widget.task),
        ),
      ],
    );
  }

  // widget to have the options to edit, delete or bookmark the task
}


// ListTile(
//       title: Text(
//         widget.task.title,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           decoration: widget.task.isDone!
//               ? TextDecoration.lineThrough
//               : TextDecoration.none,
//         ),
//       ),
//       trailing: Checkbox(
//         value: widget.task.isDone,
//         activeColor: widget.task.isDeleted! ? Colors.grey : Colors.blue,
//         onChanged: (_) =>
//             widget.task.isDeleted! ? null : _updateTask(context, widget.task),
//       ),
//       onLongPress: () => _deleteOrRemoveTask(context, widget.task),
//     );
