part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

final class FetchTasksInitial extends TasksEvent {}

final class SaveTaskEvent extends TasksEvent {
  final Task unsavedTask;

  SaveTaskEvent({required this.unsavedTask});
}

final class RemoveTaskEvent extends TasksEvent {
  final int id;

  RemoveTaskEvent({required this.id});
}

final class StoreTaskToBackendEvent extends TasksEvent {}
