import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {

    // Sign Up Event

    on<SignUpEvent>((event, emit) async {

      emit(AuthLoading());
      try {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        await userCredential.user?.updateDisplayName(event.userName);

        emit(AuthAuthenticated(message: "User authenticated successfully"));

      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          emit(AuthUnauthenticated(errorMessage: 'The password provided is too weak.'));
        } else if (error.code == 'email-already-in-use') {
          emit(AuthUnauthenticated(errorMessage: 'The account already exists for that email.'));
        } else {
          emit(AuthUnauthenticated(errorMessage: error.message ?? 'An unknown error occurred.'));
        }
      } catch (error) {
        emit(AuthUnauthenticated(errorMessage: 'An unknown error occurred.'));
      }

    
    });


    // Sign In Event

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(message: "User signed in successfully"));

      } on FirebaseAuthException catch (error) {
        if (error.code == 'user-not-found') {
          emit(AuthUnauthenticated(errorMessage: 'No user found for that email.'));
        } else if (error.code == 'wrong-password') {
          emit(AuthUnauthenticated(errorMessage: 'Wrong password provided for that user.'));
        } else {
          emit(AuthUnauthenticated(errorMessage: error.message ?? 'An unknown error occurred.'));
        }
      } catch (error) {
        emit(AuthUnauthenticated(errorMessage: 'An unknown error occurred.'));
      }
    });


    // Sign with Google Event

    on<GoogleSignInEvent>((event, emit) async {

      try {

        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          emit(AuthUnauthenticated(errorMessage: 'Google sign-in was cancelled.'));
          return;
        }

        emit(AuthLoading());

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        emit(AuthAuthenticated(message: "User signed in with Google successfully"));

      } on FirebaseAuthException catch (error) {
        emit(AuthUnauthenticated(errorMessage: error.message ?? 'An unknown error occurred during Google sign-in.'));
      } catch (error) {
        emit(AuthUnauthenticated(errorMessage: 'An unknown error occurred during Google sign-in.'));
      }
    });



    // Sign in with Phone Event

    String? _verificationId;

    on<PhoneSignInEvent>((event, emit) async {

      final emitCallback = emit;

      if(!emitCallback.isDone){
        emitCallback(AuthPhoneLoading());
      }

      

      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
            if(!emitCallback.isDone){
              emitCallback(AuthAuthenticated(message: "Phone number automatically verified and user signed in"));
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            if(!emitCallback.isDone){
              if (e.code == 'invalid-phone-number') {
                emitCallback(AuthUnauthenticated(errorMessage: 'The provided phone number is not valid.'));
            }else {
                emitCallback(AuthUnauthenticated(errorMessage: e.message ?? 'Phone verification failed.'));
              }
            }
          },
          codeSent: (String verId, int? resendToken) {
              _verificationId = verId;
              if (!emitCallback.isDone) {
                emitCallback(AuthOtpSent(message: "Verification code sent to phone number"));
              }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            _verificationId = verificationId;
          },
        );
      } catch (error) {
        if (!emitCallback.isDone) {
          emitCallback(AuthUnauthenticated(errorMessage: 'An unknown error occurred during phone number verification.'));
        }
      }
    });


    
    // OTP Sent Event

    on<AuthOtpSentEvent>((event, emit) async {

      final emitCallback = emit;

      if(!emitCallback.isDone){
        emitCallback(AuthOtpLoading());
      }

      try{

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: event.otpCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      if(!emitCallback.isDone){
          emitCallback(AuthAuthenticated(message: "User signed in with phone number successfully"));
      }
      }catch(e){
        if(!emitCallback.isDone){
            emitCallback(AuthUnauthenticated(errorMessage: "Invalid OTP"));
        }
      }
    });



    on<AuthAnonymousEvent>((event, emit) async {

      emit(AuthLoading());

      try{
        await FirebaseAuth.instance.signInAnonymously();
        emit(AuthAuthenticated(message: "User signed in anonymously"));
      }catch(e){
        emit(AuthUnauthenticated(errorMessage: "Error signing in anonymously"));
      }

    });



    // Forgot password event


    on<ForgotPasswordEvent>((event, emit) async {

      try{

        await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
        emit(AuthResetPasswordSucess(message: "Password reset email sent"));
      }
      catch(e){
        emit(AuthResetPasswordError(errorMessage: "Error sending password reset email"));
      }

    });


  }
}
