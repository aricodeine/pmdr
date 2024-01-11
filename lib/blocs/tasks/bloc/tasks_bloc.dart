import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pmdr/main.dart';
import 'package:pmdr/models/task/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  List<Task> tasksList = [];
  TasksBloc() : super(TasksInitial()) {
    on<FetchTasksInitial>(fetchTasksInitial);
    on<SaveTaskEvent>(saveTaskEvent);
    on<RemoveTaskEvent>(removeTaskEvent);
  }

  FutureOr<void> fetchTasksInitial(FetchTasksInitial tasks, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    try {
      await for (final tasks in objectbox.getTasks()) {
        tasksList = tasks;
        emit(TasksFetchedState(fetchedTasks: tasksList));
      }
      // emit(TasksFetchedState(fetchedTasks: tasksList));
    } catch (e) {
      emit(TasksErrorState(errorText: e.toString()));
    }
  }

  FutureOr<void> saveTaskEvent(SaveTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    try {
      await objectbox.saveTask(event.unsavedTask);
      emit(TaskSavedState());
      objectbox.getTasks().listen((tasks) {
        tasksList = tasks;
      });
      emit(TasksFetchedState(fetchedTasks: tasksList));
    } catch (e) {
      emit(TasksErrorState(errorText: e.toString()));
    }
  }

  FutureOr<void> removeTaskEvent(RemoveTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    try {
      await objectbox.removeTask(event.id);

      emit(TaskRemovedState());
      objectbox.getTasks().listen((tasks) {
        tasksList = tasks;
      });
      emit(TasksFetchedState(fetchedTasks: tasksList));
    } catch (e) {
      emit(TasksErrorState(errorText: e.toString()));
    }
  }
}
