import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class PmdrTimer extends StatelessWidget {
  const PmdrTimer({
    super.key,
    required int mins,
    required CountDownController controller,
  })  : _mins = mins,
        _controller = controller;

  final int _mins;
  final CountDownController _controller;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: _mins * 60,
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
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: false,
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
    );
  }
}
