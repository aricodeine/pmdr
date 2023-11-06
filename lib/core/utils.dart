import 'package:pmdr/models/timer_profile/timer_profile.dart';

class Utilities {
  static bool? isTimerBusy = false;
  static TimerProfile currentlySetProfile =
      const TimerProfile(profileName: 'Default', numberOfMins: 25);
}
