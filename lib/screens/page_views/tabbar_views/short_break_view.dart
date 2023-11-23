import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pmdr/blocs/timer/bloc/timer_bloc.dart';
import 'package:pmdr/core/utils.dart';
import 'package:pmdr/core/widgets/pmdr_timer.dart';

class ShortBreakView extends StatelessWidget {
  ShortBreakView({super.key});

  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PmdrTimer(
          mins: Utilities.currentlySetProfile.numberOfMins,
          controller: _controller,
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
                            .add(TimerPauseEvent(controller: _controller));
                      },
                      icon: const Icon(
                        Icons.pause_rounded,
                        size: 60,
                      )),
                  const Gap(20),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<TimerBloc>(context)
                            .add(TimerEndEvent(controller: _controller));
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
                        .add(TimerResumeEvent(controller: _controller));
                  },
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    size: 60,
                  ));
            }

            return IconButton(
              onPressed: () =>
                  BlocProvider.of<TimerBloc>(context).add(TimerStartEvent(controller: _controller)),
              icon: const Icon(Icons.play_arrow_rounded, size: 60),
            );
          },
        ),
      ],
    );
  }
}
