import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<TimerInitialEvent>(timerInitialEvent);
  }

  FutureOr<void> timerInitialEvent(
      TimerInitialEvent event, Emitter<TimerState> emit) async {
    emit(TimerInitial());
    await Future.delayed(const Duration(seconds: 3));
    emit(TimerReadyState());
  }
}
