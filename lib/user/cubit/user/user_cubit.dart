import 'package:aplikasi_project/user/model/user_model.dart';
import 'package:aplikasi_project/user/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<CubitState> {
  UserCubit() : super(CubitInitial());

  Repository repository = Repository();
  void getUserList() async {
    try {
      final result = await repository.fetchUser();
      emit(FetchUserSuccess(result));
    } catch (e) {
      emit(FetchUserFailed(
        e.toString(),
      ));
    }
  }
}
