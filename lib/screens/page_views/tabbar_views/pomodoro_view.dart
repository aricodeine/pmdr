import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pmdr/blocs/tasks/bloc/tasks_bloc.dart';
import 'package:pmdr/blocs/timer/bloc/timer_bloc.dart';
import 'package:pmdr/core/utils.dart';
import 'package:pmdr/core/constants.dart';
import 'package:pmdr/core/widgets/add_button.dart';
import 'package:pmdr/core/widgets/add_task_form.dart';
import 'package:pmdr/core/widgets/pmdr_timer.dart';
import 'package:pmdr/models/task/task.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView(
      {super.key, required this.countdownController, required PageController pageController})
      : _pageController = pageController;

  final CountDownController countdownController;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    void timerGarbageCollector() {
      final timerState = context.read<TimerBloc>().state;
      if (timerState is TimerStartedState || timerState is TimerPausedState) {
        context.read<TimerBloc>().add(TimerEndEvent(controller: countdownController));
      }
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PmdrTimer(
            mins: Utilities.pomodoroProfile.numberOfMins,
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
                          BlocProvider.of<TimerBloc>(context)
                              .add(TimerEndEvent(controller: countdownController));
                          timerGarbageCollector();
                          _pageController.animateToPage(1,
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
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksFetchedState) {
                // return StreamBuilder(
                //     stream: state.tasksStream,
                //     builder: (context, snapshot) {
                //       List<Task> tasks = snapshot.data ?? [];
                // return ListView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: tasks.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text('${tasks[index].id} ${tasks[index].taskName}'),
                //       );
                //     });
                //     });
                List<Task> tasks = state.fetchedTasks;
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${tasks[index].id} ${tasks[index].taskName}'),
                      );
                    });
              }
              if (state is TasksLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return const Text('No Tasks here!!');
            },
          ),
          AddButton(onTap: () async {
            Task? newTask = await showDialog<Task>(
                context: context,
                builder: (context) {
                  return const AddTaskForm();
                });

            if (newTask != null && context.mounted) {
              BlocProvider.of<TasksBloc>(context).add(SaveTaskEvent(unsavedTask: newTask));
            }
          }),
        ],
      ),
    );
  }
}
