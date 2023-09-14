import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  final List<Task> taskList;

  const TaskList({
    super.key,
    required this.taskList,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: taskList
              .map((task) => ExpansionPanelRadio(
                    value: task.id,
                    headerBuilder: (context, isOpen) => TaskTile(task: task),
                    body: _buildBody(task),
                  ))
              .toList(),
        ),
      ),
    );
  }

  ListTile _buildBody(Task task) {
    return ListTile(
      title: SelectableText.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: "Text:\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: task.title),
            const TextSpan(
              text: "\n\nDescription:\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: task.description),
          ],
        ),
      ),
    );
  }
}


// Expanded(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: taskList.length,
//         itemBuilder: (context, index) {
//           var task = taskList[index];
//           return TaskTile(task: task);
//         },
//       ),
//     );