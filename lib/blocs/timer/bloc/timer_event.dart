part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent {}

final class TimerInitialEvent extends TimerEvent {}

final class TimerStartEvent extends TimerEvent {
  final CountDownController controller;

  TimerStartEvent({required this.controller});
}

final class TimerPauseEvent extends TimerEvent {
  final CountDownController controller;

  TimerPauseEvent({required this.controller});
}

final class TimerResumeEvent extends TimerEvent {
  final CountDownController controller;

  TimerResumeEvent({required this.controller});
}

final class TimerEndEvent extends TimerEvent {
  final CountDownController controller;
  final VibrateCubit vibrateCubit;
  final bool canVibrateNow;

  TimerEndEvent({this.canVibrateNow = false, required this.vibrateCubit, required this.controller});
}
