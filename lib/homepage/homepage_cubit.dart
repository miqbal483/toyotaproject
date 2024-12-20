import 'package:bloc/bloc.dart';

class HomepageCubit extends Cubit<int> {
  HomepageCubit() : super(0);
//add 1 to the current state
  void increment() => emit(state + 1); //emit is a can notifi or feedback to ui
//kurangi 1 to the current state
  void decrement() => emit(state - 1);
}
