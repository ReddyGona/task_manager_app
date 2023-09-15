import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

// https://flowbite.com/tools/tailwind-cheat-sheet/

// changing the Bloc<TasksEvent, TasksState> to HydratedBloc<TasksEvent, TasksState>
// for persisting the data in memory of the app
class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavouriteOrUnfavouriteTask>(_onMarkFavouriteOrUnfavouriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    // getting access to the current state
    final state = this.state;
    // emmitting the task state after adding the task to current list
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks,
      // getting the removedTasks from the state
      removedTasks: state.removedTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    emit(
      TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
        // deleting the tasks only from the removedTasks list
        removedTasks: List.from(state.removedTasks)..remove(task),
      ),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task; // updated task value provided by the user

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;

    // updating the value of isDone
    if (task.isDone == false) {
      if (task.isFavourite == false) {
        // removing the task from the pending list and then adding the
        // data to the completedTask list with value of isDone true
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(0, task.copyWith(isDone: true));
      } else {
        int taskIndex = favouriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(0, task.copyWith(isDone: true));
        favouriteTasks = List.from(favouriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavourite == false) {
        // removing the task from the completed list and adding the task to the
        // pending list with the value of isDone as false
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        int taskIndex = favouriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
        completedTasks = List.from(completedTasks)..remove(task);
        favouriteTasks = List.from(favouriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  // method to remove the task
  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favouriteTasks: List.from(state.favouriteTasks)..remove(event.task),
        // adding removed task to the removed task list
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true)),
      ),
    );
  }

  // method to mark task favourite or unfavourite
  void _onMarkFavouriteOrUnfavouriteTask(
    MarkFavouriteOrUnfavouriteTask event,
    Emitter<TasksState> emit,
  ) {
    final state = this.state;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavourite == false) {
        int taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks = List.from(favouriteTasks)
          ..insert(0, event.task.copyWith(isFavourite: true));
        // favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        int taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks = List.from(favouriteTasks)..remove(event.task);
        // favouriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavourite == false) {
        int taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks = List.from(favouriteTasks)
          ..insert(0, event.task.copyWith(isFavourite: true));
        // favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        int taskIndex = pendingTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks = List.from(favouriteTasks)..remove(event.task);
        // favouriteTasks.remove(event.task);
      }
    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  // method to edit the task
  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (event.currentTask.isFavourite == true) {
      favouriteTasks = List.from(favouriteTasks)
        ..remove(event.currentTask)
        ..insert(0, event.updatedTask);
    }
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.currentTask)
        ..insert(0, event.updatedTask),
      completedTasks: List.from(state.completedTasks)
        ..remove(event.currentTask),
      favouriteTasks: favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks)
        ..insert(
            0,
            event.task.copyWith(
              isDeleted: false,
              isDone: false,
              isFavourite: false,
            )),
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks,
    ));
  }

  // method to delete all the tasks
  void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..clear(),
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks,
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
