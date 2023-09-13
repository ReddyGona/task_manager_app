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
      allTasks: List.from(state.allTasks)..add(event.task),
      // getting the removedTasks from the state
      removedTasks: state.removedTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    emit(
      TasksState(
        allTasks: state.allTasks,
        // deleting the tasks only from the removedTasks list
        removedTasks: List.from(state.removedTasks)..remove(task),
      ),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task; // updated task value provided by the user

    // getting the insdex of the task provided by the user
    final index = state.allTasks.indexOf(task);

    // first remove the task and then update the along with adding the task
    List<Task> allTasks = List.from(state.allTasks)..remove(task);

    // updating the value of isDone
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));

    emit(TasksState(
      allTasks: allTasks,
      // getting the removedTasks from the state
      removedTasks: state.removedTasks,
    ));
  }

  // method to remove the task
  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..remove(event.task),
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
