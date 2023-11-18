import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pmdr/blocs/timer/bloc/timer_bloc.dart';
import 'package:pmdr/core/constants.dart';
import 'package:pmdr/core/utils.dart';
import 'package:pmdr/core/widgets/app_title.dart';
import 'package:pmdr/core/widgets/pmdr_timer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime today = DateTime.now();
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimerBloc>(context).add(TimerInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          scrolledUnderElevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      today.day.toString(),
                      style: kTodaysDateStyle,
                    ),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat('E').format(today), style: kAppBarSubtextStyle),
                        Text(DateFormat('MMM y').format(today), style: kAppBarSubtextStyle),
                      ],
                    )
                  ],
                ),
                const AppTitle(title: 'Pomodoro'),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        decoration: kBackgroundDecoration,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(10),
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
                    onPressed: () => BlocProvider.of<TimerBloc>(context)
                        .add(TimerStartEvent(controller: _controller)),
                    icon: const Icon(Icons.play_arrow_rounded, size: 60),
                  );
                },
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: const Icon(Icons.list),
                      trailing: const Text(
                        "GFG",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text("List item $index"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
