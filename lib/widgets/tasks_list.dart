import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasksList;
  const TasksList({Key? key, required this.tasksList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTasksListUI();
  }

  ListView _buildTasksListUI() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tasksList.length,
      itemBuilder: (context, index) {
        return _buildItemTile(tasksList[index]);
      },
    );
  }

  ListTile _buildItemTile(Task task) => ListTile(
        title: Text(task.title),
        trailing: _buildCheckBoxForTask(task),
      );

  Checkbox _buildCheckBoxForTask(Task task) {
    return Checkbox(
      value: task.isDone,
      onChanged: (value) {},
    );
  }
}
