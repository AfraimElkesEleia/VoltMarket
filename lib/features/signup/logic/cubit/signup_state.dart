part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupFailed extends SignupState {
  final String errMsg;
  SignupFailed({required this.errMsg});
}

final class SignupSuccess extends SignupState {}

final class Loading extends SignupState {}
