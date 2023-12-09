import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pmdr/main.dart';
import 'package:pmdr/models/task/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  late StreamSubscription<List<Task>> _tasksSubscription;
  TasksBloc() : super(TasksInitial()) {
    on<FetchTasksInitial>(fetchTasksInitial);
    on<SaveTaskEvent>(saveTaskEvent);
    on<RemoveTaskEvent>(removeTaskEvent);
  }

  FutureOr<void> fetchTasksInitial(FetchTasksInitial event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());
    try {
      Stream<List<Task>> streamOfTasks = objectbox.getTasks();
      emit(TasksFetchedState(tasksStream: streamOfTasks));
    } catch (e) {
      emit(TasksErrorState(errorText: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _tasksSubscription.cancel();
    return super.close();
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
