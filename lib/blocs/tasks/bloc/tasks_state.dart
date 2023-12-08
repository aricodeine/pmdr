part of 'tasks_bloc.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TaskAddedState extends TasksState {}

final class TaskRemovedState extends TasksState {}
