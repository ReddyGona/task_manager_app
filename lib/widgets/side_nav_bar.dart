import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/screens/recycle_bin.dart';
import 'package:flutter_tasks_app/screens/tasks_screen.dart';
import 'package:flutter_tasks_app/widgets/theme_switch_widget.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 20,
              ),
              color: Colors.grey,
              child: Text(
                "Task Drawer",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(TasksScreen.routeName),
                  leading: const Icon(Icons.folder_special),
                  title: const Text("My Tasks"),
                  trailing: Text(
                    state.allTasks.isEmpty
                        ? ""
                        : state.allTasks.length.toString(),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(RecycleBinScreen.routeName),
                  leading: const Icon(Icons.delete),
                  title: const Text("Bin"),
                  trailing: Text(
                    state.removedTasks.isEmpty
                        ? ""
                        : "${state.removedTasks.length}",
                  ),
                );
              },
            ),
            const Divider(),
            // switch to change the theme of the app
            const ThemeSwitchWidget(),
          ],
        ),
      ),
    );
  }
}
