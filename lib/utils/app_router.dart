// router file for the app

import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/recycle_bin.dart';
import 'package:flutter_tasks_app/screens/tasks_screen.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RecycleBinScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());
      case TasksScreen.routeName:
        return MaterialPageRoute(builder: (_) => const TasksScreen());
      default:
        return MaterialPageRoute(builder: (_) => const TasksScreen());
    }
  }
}
