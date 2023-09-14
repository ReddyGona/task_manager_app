import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/utils/guid_generator.dart';

class AddTaskBottomSheet extends StatelessWidget {
  AddTaskBottomSheet({super.key});

  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  void _addTaskOnPressed(BuildContext context) {
    Task task = Task(
      id: GUIDGen.generate(), // generating a uniqu id for each task
      title: _titleEditingController.text,
      description: _descriptionEditingController.text,
    );

    // using the read<TaskBloc>() method from the context instance and then
    // calling the add() method and then passing the AddTask() state having the
    // task as input to add a new task
    context.read<TasksBloc>().add(AddTask(task: task));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Task",
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _titleEditingController,
            autofocus: true,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Description",
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _descriptionEditingController,
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              label: Text('Description'),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          _addTaskAndCancelButtonUI(context),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Row _addTaskAndCancelButtonUI(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _addTaskOnPressed(context),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
