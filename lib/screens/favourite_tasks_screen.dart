import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/widgets/task_list.dart';

class FavouriteTasksScreen extends StatelessWidget {
  static const String routeName = "FavouriteTasksScreen";
  const FavouriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> favouriteTasks = state.favouriteTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            state.favouriteTasks.isEmpty
                ? const SizedBox()
                : Center(
                    child: Chip(
                      label: Text(
                        '${state.favouriteTasks.length} ${state.favouriteTasks.length == 1 ? "Task" : "Tasks"}',
                      ),
                    ),
                  ),
            TaskList(taskList: favouriteTasks),
          ],
        );
      },
    );
  }
}
