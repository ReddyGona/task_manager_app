import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/models/task.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final Task currentTask;

  const EditTaskBottomSheet({
    super.key,
    required this.currentTask,
  });

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _descriptionEditingController = TextEditingController();

  void _editTaskOnPressed(BuildContext context) {
    Task updatedTask = Task(
      id: widget.currentTask.id,
      title: _titleEditingController.text,
      description: _descriptionEditingController.text,
      createdAt: DateTime.now().toString(),
      isFavourite: widget.currentTask.isFavourite,
      isDone: false,
    );
    context.read<TasksBloc>().add(EditTask(
          currentTask: widget.currentTask,
          updatedTask: updatedTask,
        ));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _titleEditingController =
        TextEditingController(text: widget.currentTask.title);
    _descriptionEditingController =
        TextEditingController(text: widget.currentTask.description);
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
          onPressed: () => _editTaskOnPressed(context),
          child: const Text("Save"),
        ),
      ],
    );
  }
}
