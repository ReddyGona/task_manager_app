import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/widgets/task_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  static const String routeName = "completedTasksScreen";
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> completedTasks = state.completedTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            state.completedTasks.isEmpty
                ? const SizedBox()
                : Center(
                    child: Chip(
                      label: Text(
                        '${state.completedTasks.length} ${state.completedTasks.length == 1 ? "Task" : "Tasks"}',
                      ),
                    ),
                  ),
            TaskList(taskList: completedTasks),
          ],
        );
      },
    );
  }
}
