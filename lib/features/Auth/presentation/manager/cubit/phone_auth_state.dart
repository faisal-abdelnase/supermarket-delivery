
part of 'phone_auth_cubit.dart';



sealed class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object> get props => [];
}

final class PhoneAuthInitial extends PhoneAuthState {}

final class PhoneAuthLoading extends PhoneAuthState {}

final class PhoneAuthCodeSent extends PhoneAuthState {
  final String verificationId;
  const PhoneAuthCodeSent({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}



final class PhoneAuthVerified extends PhoneAuthState {}

final class PhoneAuthError extends PhoneAuthState {
  final String errorMessage;
  const PhoneAuthError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
