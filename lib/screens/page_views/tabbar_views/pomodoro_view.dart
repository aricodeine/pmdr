import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pmdr/blocs/timer/bloc/timer_bloc.dart';
import 'package:pmdr/core/utils.dart';
import 'package:pmdr/core/widgets/add_button.dart';
import 'package:pmdr/core/widgets/pmdr_timer.dart';

class PomodoroView extends StatefulWidget {
  const PomodoroView({super.key, required this.countdownController});

  final CountDownController countdownController;

  @override
  State<PomodoroView> createState() => _PomodoroViewState();
}

class _PomodoroViewState extends State<PomodoroView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PmdrTimer(
            mins: Utilities.pomodoroProfile.numberOfMins,
            controller: widget.countdownController,
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
                              .add(TimerPauseEvent(controller: widget.countdownController));
                        },
                        icon: const Icon(
                          Icons.pause_rounded,
                          size: 60,
                        )),
                    const Gap(20),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<TimerBloc>(context)
                              .add(TimerEndEvent(controller: widget.countdownController));
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
                          .add(TimerResumeEvent(controller: widget.countdownController));
                    },
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 60,
                    ));
              }

              return IconButton(
                onPressed: () => BlocProvider.of<TimerBloc>(context)
                    .add(TimerStartEvent(controller: widget.countdownController)),
                icon: const Icon(Icons.play_arrow_rounded, size: 60),
              );
            },
          ),
          // ListView.builder(
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemCount: 20,
          //   itemBuilder: (BuildContext context, int index) {
          //     return ListTile(
          //         leading: const Icon(Icons.list),
          //         trailing: const Text(
          //           "GFG",
          //           style: TextStyle(color: Colors.green, fontSize: 15),
          //         ),
          //         title: Text("List item $index"));
          //   },
          // ),
          AddButton(onTap: () {}),
        ],
      ),
    );
  }
}
