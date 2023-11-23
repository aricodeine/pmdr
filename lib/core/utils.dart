import 'package:pmdr/models/timer_profile/timer_profile.dart';

class Utilities {
  static bool? isTimerBusy = false;
  static TimerProfile pomodoroProfile =
      const TimerProfile(profileName: 'Pomodoro', numberOfMins: 25);
  static TimerProfile shortBreakProfile =
      const TimerProfile(profileName: 'Short Break', numberOfMins: 5);
  static TimerProfile longBreakProfile =
      const TimerProfile(profileName: 'Short Break', numberOfMins: 15);
}
