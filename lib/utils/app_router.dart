// router file for the app
import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/recycle_bin.dart';
import 'package:flutter_tasks_app/screens/pending_tasks_screen.dart';
import 'package:flutter_tasks_app/widgets/bottom_nav_bar.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RecycleBinScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());
      case PendingTasksScreen.routeName:
        return MaterialPageRoute(builder: (_) => const PendingTasksScreen());
      case BottomNavBar.routeName:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      default:
        return MaterialPageRoute(builder: (_) => const PendingTasksScreen());
    }
  }
}
