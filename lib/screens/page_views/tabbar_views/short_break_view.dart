import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pmdr/blocs/timer/bloc/timer_bloc.dart';
import 'package:pmdr/core/constants.dart';
import 'package:pmdr/core/utils.dart';
import 'package:pmdr/core/widgets/pmdr_timer.dart';
import 'package:pmdr/cubits/cubit/vibrate_cubit.dart';

class ShortBreakView extends StatelessWidget {
  const ShortBreakView(
      {super.key, required this.countdownController, required PageController pageController})
      : _pageController = pageController;

  final CountDownController countdownController;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    void timerGarbageCollector() {
      final timerState = context.read<TimerBloc>().state;
      if (timerState is TimerStartedState || timerState is TimerPausedState) {
        context.read<TimerBloc>().add(TimerEndEvent(
            controller: countdownController, vibrateCubit: context.read<VibrateCubit>()));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PmdrTimer(
          mins: Utilities.shortBreakProfile.numberOfMins,
          controller: countdownController,
        ),
        const Gap(10),
        BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            if (state is TimerStartedState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<TimerBloc>(context)
                            .add(TimerPauseEvent(controller: countdownController));
                      },
                      icon: const Icon(
                        Icons.pause_rounded,
                        size: 60,
                      )),
                  const Gap(20),
                  IconButton(
                      onPressed: () {
                        context.read<TimerBloc>().add(TimerEndEvent(
                            controller: countdownController,
                            vibrateCubit: context.read<VibrateCubit>(),
                            canVibrateNow: true));
                        timerGarbageCollector();
                        _pageController.animateToPage(0,
                            duration: kNavigationDuration, curve: Curves.easeInQuad);
                      },
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        size: 60,
                      ))
                ],
              );
            }

            if (state is TimerPausedState) {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<TimerBloc>(context)
                        .add(TimerResumeEvent(controller: countdownController));
                  },
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    size: 60,
                  ));
            }

            return IconButton(
              onPressed: () => BlocProvider.of<TimerBloc>(context)
                  .add(TimerStartEvent(controller: countdownController)),
              icon: const Icon(Icons.play_arrow_rounded, size: 60),
            );
          },
        ),
      ],
    );
  }
}
