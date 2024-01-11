import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pmdr/main.dart';
import 'package:pmdr/models/task/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<FetchTasksInitial>(fetchTasksInitial);
    on<SaveTaskEvent>(saveTaskEvent);
    on<RemoveTaskEvent>(removeTaskEvent);
  }

  FutureOr<void> fetchTasksInitial(FetchTasksInitial tasks, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    try {
      await for (final tasks in objectbox.getTasks()) {
        emit(TasksFetchedState(fetchedTasks: tasks));
      }
    } catch (e) {
      emit(TasksErrorState(errorText: e.toString()));
    }
  }

  FutureOr<void> saveTaskEvent(SaveTaskEvent event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());
    try {
      objectbox.saveTask(event.unsavedTask);
      emit(TaskSavedState());
    } catch (e) {
      emit(TasksErrorState(errorText: e.toString()));
    }
  }

  FutureOr<void> removeTaskEvent(RemoveTaskEvent event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());
    try {
      objectbox.removeTask(event.id);

      emit(TaskRemovedState());
    } catch (e) {
      emit(TasksErrorState(errorText: e.toString()));
    }
  }
}
