import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

// changing the Bloc<TasksEvent, TasksState> to HydratedBloc<TasksEvent, TasksState>
// for persisting the data in memory of the app
class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
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

    // updating the value of isDone
    if (task.isDone == false) {
      // removing the task from the pending list and then adding the
      // data to the completedTask list with value of isDone true
      pendingTasks = List.from(pendingTasks)..remove(task);
      completedTasks = List.from(completedTasks)
        ..insert(0, task.copyWith(isDone: true));
    } else {
      // removing the task from the completed list and adding the task to the
      // pending list with the value of isDone as false
      completedTasks = List.from(completedTasks)..remove(task);
      pendingTasks = List.from(pendingTasks)
        ..insert(0, task.copyWith(isDone: false));
    }

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: state.favouriteTasks,
      // getting the removedTasks from the state
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

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
