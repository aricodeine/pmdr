part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent {}

class TimerInitialEvent extends TimerEvent {}

class TimerStartEvent extends TimerEvent {}

class TimerPauseEvent extends TimerEvent {}

class TimerStopEvent extends TimerEvent {}

class TimerResumeEvent extends TimerEvent {}
