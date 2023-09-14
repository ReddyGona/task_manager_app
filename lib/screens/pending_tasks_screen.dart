import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/widgets/task_list.dart';

class PendingTasksScreen extends StatelessWidget {
  static const String routeName = "pendingTasksScreen";
  const PendingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> pendingTasks = state.pendingTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${state.pendingTasks.length} ${state.pendingTasks.length == 1 ? "Pending Task" : "Pending Tasks"} | ${state.completedTasks.length} ${state.completedTasks.length == 1 ? "Completed Task" : "Completed Tasks"}',
                ),
              ),
            ),
            TaskList(taskList: pendingTasks),
          ],
        );
      },
    );
  }
}
