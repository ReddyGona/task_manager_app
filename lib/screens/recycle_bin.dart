import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/widgets/side_nav_bar.dart';
import 'package:flutter_tasks_app/widgets/task_list.dart';

class RecycleBinScreen extends StatelessWidget {
  static const String routeName = "recycleBinScreen";
  const RecycleBinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> removedTasks = state.removedTasks;
        return Scaffold(
          drawer: const SideNavBar(),
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              removedTasks.isEmpty
                  ? const SizedBox()
                  : Center(
                      child: Chip(
                        label: Text(
                          '${removedTasks.length} ${removedTasks.length == 1 ? "Task" : "Tasks"}',
                        ),
                      ),
                    ),
              TaskList(taskList: removedTasks),
            ],
          ),
        );
      },
    );
  }
}
