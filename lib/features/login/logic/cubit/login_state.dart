part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class Loading extends LoginState {}

final class SinginSuccess extends LoginState {}

final class EmailNotVerified extends LoginState {}

final class SigninFailed extends LoginState {
  final String message;
  SigninFailed({required this.message});
}

final class ResetPasswordEmailIsSent extends LoginState {}

final class ForgetPasswordErrorOccured extends LoginState {
  final String message;
  ForgetPasswordErrorOccured({required this.message});
}

final class GoogleAuthUserNull extends LoginState {}
