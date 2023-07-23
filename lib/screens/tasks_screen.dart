// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/widgets/add_task_bottom_sheet.dart';
import 'package:flutter_tasks_app/widgets/tasks_list.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  void _addTaskOnPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {},
      builder: (context, state) {
        // getting all tasks from the state
        List<Task> tasksList = state.allTasks;

        return Scaffold(
          appBar: _buildAppBarUI(),
          body: _buildBodyUI(tasksList),
          floatingActionButton: _buildButtonToAddTask(context),
        );
      },
    );
  }

  FloatingActionButton _buildButtonToAddTask(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addTaskOnPressed(context),
      tooltip: 'Add Task',
      child: const Icon(Icons.add),
    );
  }

  Column _buildBodyUI(List<Task> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(child: Chip(label: Text('Tasks:'))),
        TasksList(tasksList: tasks),
      ],
    );
  }

  AppBar _buildAppBarUI() {
    return AppBar(
      title: const Text('Tasks App'),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}
