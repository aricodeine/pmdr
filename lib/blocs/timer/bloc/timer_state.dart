part of 'timer_bloc.dart';

@immutable
sealed class TimerState {}

final class TimerInitial extends TimerState {}

final class TimerReadyState extends TimerState {}

final class TimerStartedState extends TimerState {}

final class TimerPausedState extends TimerState {}

final class TimerStoppedState extends TimerState {}

final class TimerFinishClickedState extends TimerState {}
