import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class TimerService {
  static void startTimer(CountDownController controller) {
    controller.start();
  }

  static void pauseTimer(CountDownController controller) {
    controller.pause();
  }

  static void resumeTimer(CountDownController controller) {
    controller.resume();
  }

  static void endTimer(CountDownController controller) {
    controller.reset();
  }
}
