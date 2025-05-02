part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class Loading extends ProfileState {}

final class ProfileLoaded extends ProfileState {}

final class LoggedOut extends ProfileState {}

final class NetworkError extends ProfileState {}

final class RequestPermission extends ProfileState {}

final class EnablGps extends ProfileState {}

final class ErrorGps extends ProfileState {
  late final String message;
  ErrorGps({required this.message});
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
