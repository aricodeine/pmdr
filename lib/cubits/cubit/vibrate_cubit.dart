import 'package:bloc/bloc.dart';
import 'package:vibration/vibration.dart';

class VibrateCubit extends Cubit<bool> {
  VibrateCubit() : super(false);

  void hasVibrationFunctionality() async {
    bool hasVibrate = await Vibration.hasVibrator() ?? false;
    emit(hasVibrate);
  }

  void performVibration() {
    Vibration.vibrate(duration: 200);
  }
}
