import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_market/core/utils/Functions/upload_image.dart';


part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  String? _verificationId;
  String? _userName;

  // Sign in with Phone
  Future<void> signInWithPhone({
    required String phoneNumber,
    required String userName,
  }) async {
    emit(PhoneAuthLoading());
    _userName = userName;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          emit(PhoneAuthVerified());
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            emit(PhoneAuthError(
              errorMessage: 'The provided phone number is not valid.',
            ));
          } else {
            emit(PhoneAuthError(
              errorMessage: e.message ?? 'Phone verification failed.',
            ));
          }
        },
        codeSent: (String verId, int? resendToken) {
          _verificationId = verId;
          emit(PhoneAuthCodeSent(verificationId: verId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (error) {
      emit(PhoneAuthError(
        errorMessage:
            'An unknown error occurred during phone number verification.',
      ));
    }
  }


  

  // Verify OTP
  Future<void> verifyOtp(String otpCode) async {
    emit(PhoneAuthLoading());

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpCode,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;

      if (user != null) {
        final photoUrl = await uploadDefaultProfileImage(user.uid);
        await user.updatePhotoURL(photoUrl);
        await user.updateDisplayName(_userName);

        await user.reload();
      }

      emit(PhoneAuthVerified());
    } catch (e) {
      emit(PhoneAuthError(errorMessage: 'Invalid OTP'));
    }
  }
}
