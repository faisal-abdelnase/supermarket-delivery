part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;
  

  SignUpEvent({required this.userName, required this.email, required this.password});
}

class ForgotPasswordEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {}

class GoogleSignUpEvent extends AuthEvent {}

class PhoneSignInEvent extends AuthEvent {}

class PhoneSignUpEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}


