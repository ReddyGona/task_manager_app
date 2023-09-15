import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/widgets/side_nav_bar.dart';
import 'package:flutter_tasks_app/widgets/task_list.dart';

class RecycleBinScreen extends StatelessWidget {
  static const String routeName = "recycleBinScreen";
  const RecycleBinScreen({super.key});

  void _deleteAllTasks(BuildContext context) {
    context.read<TasksBloc>().add(DeleteAllTasks());
  }

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
              state.removedTasks.isNotEmpty
                  ? PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.delete_forever),
                            label: const Text('Delete All Tasks'),
                          ),
                          onTap: () => _deleteAllTasks(context),
                        ),
                      ],
                    )
                  : const SizedBox(),
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
