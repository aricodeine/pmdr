part of 'tasks_bloc.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TasksFetchedState extends TasksState {
  final List<Task> fetchedTasks;

  TasksFetchedState({required this.fetchedTasks});
}

final class TaskSavedState extends TasksState {}

final class TaskRemovedState extends TasksState {}

final class TasksErrorState extends TasksState {
  final String errorText;

  TasksErrorState({required this.errorText});
}

final class TasksLoadingState extends TasksState {}
