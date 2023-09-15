part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  final Task task;
  const AddTask({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TasksEvent {
  final Task task;
  const UpdateTask({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;
  const DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class RemoveTask extends TasksEvent {
  final Task task;
  const RemoveTask({required this.task});

  @override
  List<Object> get props => [task];
}

class MarkFavouriteOrUnfavouriteTask extends TasksEvent {
  final Task task;
  const MarkFavouriteOrUnfavouriteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class EditTask extends TasksEvent {
  final Task currentTask;
  final Task updatedTask;
  const EditTask({required this.currentTask, required this.updatedTask});

  @override
  List<Object> get props => [currentTask, updatedTask];
}

class RestoreTask extends TasksEvent {
  final Task task;
  const RestoreTask({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteAllTasks extends TasksEvent {}
