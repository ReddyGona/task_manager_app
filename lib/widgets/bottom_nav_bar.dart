import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/completed_tasks_screen.dart';
import 'package:flutter_tasks_app/screens/favourite_tasks_screen.dart';
import 'package:flutter_tasks_app/screens/pending_tasks_screen.dart';
import 'package:flutter_tasks_app/widgets/add_task_bottom_sheet.dart';
import 'package:flutter_tasks_app/widgets/side_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = "bottomNavBar";
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Map<String, dynamic>> _screenDetails = [
    {'screenName': const PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'screenName': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'screenName': const FavouriteTasksScreen(), 'title': 'Favourite Tasks'},
  ];

  int _selectedScreenIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: AddTaskBottomSheet(),
            ),
          );
        });
  }

  void _onBottomNavBarIconPressed(int index) {
    _selectedScreenIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const SideNavBar(),
      // getting the body based on the index of the tab bar
      body: _screenDetails[_selectedScreenIndex]['screenName'],
      floatingActionButton:
          _selectedScreenIndex == 0 ? _buildAddTaskButton(context) : null,
      bottomNavigationBar: _buildBottomNavbarUI(),
    );
  }

  BottomNavigationBar _buildBottomNavbarUI() {
    return BottomNavigationBar(
      currentIndex: _selectedScreenIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.incomplete_circle_sharp),
          label: "Pending Tasks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: "Completed Tasks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favourite Tasks",
        ),
      ],
      onTap: (index) => _onBottomNavBarIconPressed(index),
    );
  }

  FloatingActionButton _buildAddTaskButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addTask(context),
      tooltip: 'Add Task',
      child: const Icon(Icons.add),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      // getting the title of appbar based on the index of the tab bar
      title: Text(_screenDetails[_selectedScreenIndex]['title']),
      actions: [
        IconButton(
          onPressed: () => _addTask(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}
