import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:meta/meta.dart';
import 'package:pmdr/core/services/timer_service.dart';
import 'package:pmdr/cubits/cubit/vibrate_cubit.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<TimerInitialEvent>(timerInitialEvent);
    on<TimerStartEvent>(timerStartEvent);
    on<TimerPauseEvent>(timerPauseEvent);
    on<TimerResumeEvent>(timerResumeEvent);
    on<TimerEndEvent>(timerEndEvent);
  }

  FutureOr<void> timerInitialEvent(TimerInitialEvent event, Emitter<TimerState> emit) {
    emit(TimerInitial());
    // await Future.delayed(const Duration(seconds: 3));
    emit(TimerReadyState());
  }

  FutureOr<void> timerStartEvent(TimerStartEvent event, Emitter<TimerState> emit) {
    TimerService.startTimer(event.controller);
    emit(TimerStartedState());
  }

  FutureOr<void> timerPauseEvent(TimerPauseEvent event, Emitter<TimerState> emit) {
    TimerService.pauseTimer(event.controller);
    emit(TimerPausedState());
  }

  FutureOr<void> timerResumeEvent(TimerResumeEvent event, Emitter<TimerState> emit) {
    TimerService.resumeTimer(event.controller);
    emit(TimerStartedState());
  }

  FutureOr<void> timerEndEvent(TimerEndEvent event, Emitter<TimerState> emit) {
    TimerService.endTimer(event.controller);
    if (event.canVibrateNow && event.vibrateCubit.state) {
      event.vibrateCubit.performVibration();
    }
    emit(TimerReadyState());
  }
}
