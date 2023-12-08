part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

final class FetchTasksInitial extends TasksEvent {}

final class CreateTaskEvent extends TasksEvent {}

final class RemoveTaskEvent extends TasksEvent {}

final class StoreTaskToBackendEvent extends TasksEvent {}
