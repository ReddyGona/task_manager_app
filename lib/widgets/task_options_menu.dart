import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';

class TaskOptionsMenuUI extends StatelessWidget {
  final VoidCallback cancelOrDeleteTaskCallback;
  final VoidCallback likeOrDislikeTaskCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final Task task;

  const TaskOptionsMenuUI({
    super.key,
    required this.cancelOrDeleteTaskCallback,
    required this.likeOrDislikeTaskCallback,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // set the icon for popup menu button
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: task.isDeleted == false
          ? (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: editTaskCallback,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  onTap: null,
                ),
                // icon to mark task favourite or unfavourite
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavourite! == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove),
                    label: task.isFavourite! == false
                        ? const Text('Add to \nBookmarks')
                        : const Text("Remove from \nBookmarks"),
                  ),
                  onTap: likeOrDislikeTaskCallback,
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                  onTap: cancelOrDeleteTaskCallback,
                ),
              ]
          : (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore_from_trash),
                    label: const Text('Restore'),
                  ),
                  onTap: restoreTaskCallback,
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete Forever'),
                  ),
                  onTap: () => cancelOrDeleteTaskCallback,
                ),
              ],
    );
  }
}
