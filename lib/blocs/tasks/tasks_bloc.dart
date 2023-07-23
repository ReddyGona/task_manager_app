import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTaskEvent);
    on<UpdateTask>(_onUpdateTaskEvent);
    on<DeleteTask>(_onDeleteTaskEvent);
  }

  // the method below will be called when AddTask event occurs
  void _onAddTaskEvent(AddTask event, Emitter<TasksState> emit) {
    // getting the current state to add the task
    final state = this.state;
    // emitting taskState after adding a new task from the event

    // getting the list of allTasks from the state and then using the from()
    // method from the List to create a list and then calling the add()
    // method and passing the event.task property to add a new task at the end
    // of the list using the task from the event prop
    emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)));
  }

  // the method below will be called when UpdateTask event occurs
  void _onUpdateTaskEvent(UpdateTask event, Emitter<TasksState> emit) {}

  // the method below will be called when DeleteTask event occurs
  void _onDeleteTaskEvent(DeleteTask event, Emitter<TasksState> emit) {}
}
