part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}
final class AuthPhoneLoading extends AuthState {}
final class AuthOtpLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final String message;
  AuthAuthenticated({required this.message});
}

final class AuthUnauthenticated extends AuthState {
  final String errorMessage;
  AuthUnauthenticated({required this.errorMessage});
}


final class  AuthResetPasswordSucess extends AuthState{
  final String message;

  AuthResetPasswordSucess({required this.message});
}
final class AuthResetPasswordError extends AuthState{
  final String errorMessage;

  AuthResetPasswordError({required this.errorMessage});
}
