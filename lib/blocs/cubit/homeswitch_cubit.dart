import 'package:bloc/bloc.dart';

class HomeswitchCubit extends Cubit<int> {
  HomeswitchCubit() : super(0);

  void change(int index) => emit(index);
}
