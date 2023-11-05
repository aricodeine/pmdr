import 'package:flutter/material.dart';
import 'package:pmdr/core/constants.dart';
import 'package:gap/gap.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class PomodoroView extends StatefulWidget {
  const PomodoroView({super.key});

  @override
  State<PomodoroView> createState() => _PomodoroViewState();
}

class _PomodoroViewState extends State<PomodoroView> {
  final int _duration = 10;
  final CountDownController _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Pomodoro',
          style: kOptionStyle,
        ),
        Gap(MediaQuery.of(context).size.height * 0.1),
        CircularCountDownTimer(
          duration: _duration,
          initialDuration: 0,
          controller: _controller,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          ringColor: const Color.fromARGB(255, 63, 60, 82),
          fillColor: const Color(0xff664eff),
          backgroundColor: const Color.fromARGB(255, 41, 39, 53),
          backgroundGradient: null,
          strokeWidth: 40.0,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(
            fontSize: 33.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: true,
          isTimerTextShown: true,
          autoStart: true,
          onStart: () {
            debugPrint('Countdown Started');
          },
          onComplete: () {
            debugPrint('Countdown Ended');
          },
          onChange: (String timeStamp) {
            debugPrint('Countdown Changed $timeStamp');
          },
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if (duration.inSeconds == 0) {
              return "Start";
            } else {
              return Function.apply(defaultFormatterFunction, [duration]);
            }
          },
        ),
      ],
    );
  }
}
