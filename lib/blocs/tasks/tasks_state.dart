part of 'tasks_bloc.dart';

// initial state for the tasks list
class TasksState extends Equatable {
  final List<Task> allTasks;
  const TasksState({this.allTasks = const []});

  @override
  List<Object> get props => [allTasks];
}
