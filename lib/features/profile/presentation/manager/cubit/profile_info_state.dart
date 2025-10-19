part of 'profile_info_cubit.dart';

sealed class ProfileInfoState {
  const ProfileInfoState();
  }

final class ProfileInfoInitial extends ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}

final class ProfileInfoSuccess extends ProfileInfoState {

  final String? email;
  final String? displayName;
  final String? photoURL;

  ProfileInfoSuccess({this.email, this.displayName, this.photoURL});
}

final class ProfileInfoError extends ProfileInfoState {
  final String errorMessage;

  ProfileInfoError({required this.errorMessage});

}
