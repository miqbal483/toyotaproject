part of 'user_cubit.dart';

sealed class CubitState extends Equatable {
  const CubitState();

  @override
  List<Object> get props => [];
}

final class CubitInitial extends CubitState {}

final class FetchuserLoading extends CubitState {}

final class FetchUserSuccess extends CubitState {
  final List<PostModel> data;

  const FetchUserSuccess(this.data);
}

final class FetchUserFailed extends CubitState {
  final String message;

  const FetchUserFailed(this.message);
}
