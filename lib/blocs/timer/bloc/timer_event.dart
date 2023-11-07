part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent {}

class TimerInitialEvent extends TimerEvent {}

class TimerStartEvent extends TimerEvent {
  final CountDownController controller;

  TimerStartEvent({required this.controller});
}

class TimerPauseEvent extends TimerEvent {
  final CountDownController controller;

  TimerPauseEvent({required this.controller});
}

class TimerResumeEvent extends TimerEvent {
  final CountDownController controller;

  TimerResumeEvent({required this.controller});
}

class TimerEndEvent extends TimerEvent {
  final CountDownController controller;

  TimerEndEvent({required this.controller});
}
