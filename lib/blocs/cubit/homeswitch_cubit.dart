import 'package:bloc/bloc.dart';

class HomeSwitchCubit extends Cubit<int> {
  HomeSwitchCubit() : super(0);

  void change(int index) => emit(index);
}
