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

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}

class GoogleSignInEvent extends AuthEvent {}

class PhoneSignInEvent extends AuthEvent {
  final String phoneNumber;
  final BuildContext context;
  final String userName;

  PhoneSignInEvent({required this.userName, required this.phoneNumber, required this.context});
}

class AuthOtpSentEvent extends AuthEvent {
  final String otpCode;

  AuthOtpSentEvent({required this.otpCode});
}


class AuthAnonymousEvent extends AuthEvent {}






class SignOutEvent extends AuthEvent {}


