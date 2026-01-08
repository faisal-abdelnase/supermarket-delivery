

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:super_market/core/utils/Functions/upload_image.dart';


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

        final user = userCredential.user;

        if(user == null){
            throw Exception("User is null");
        }

        emit(AuthAuthenticated(message: "User authenticated successfully"));


        try{
          
          final photoUrl = await uploadDefaultProfileImage(user.uid);
            await user.updatePhotoURL(photoUrl);
            await user.updateDisplayName(event.userName);

            await user.reload();
        } catch(e){
          log("PROFILE SETUP ERROR: $e");
        }

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

        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        final user = userCredential.user;
        

        if(user == null){
            throw Exception("User is null");
        }

        emit(AuthAuthenticated(message: "User signed in with Google successfully"));

        try{
          // final photoUrl = await uploadDefaultProfileImage(user.uid);
            await user.updatePhotoURL(googleUser.photoUrl);
            await user.updateDisplayName(googleUser.displayName ?? "Google User");

            await user.reload();
        } catch(e){
          log("PROFILE SETUP ERROR: $e");
        }


        

      } on FirebaseAuthException catch (error) {
        emit(AuthUnauthenticated(errorMessage: error.message ?? 'An unknown error occurred during Google sign-in.'));
      } catch (error) {
        emit(AuthUnauthenticated(errorMessage: 'An unknown error occurred during Google sign-in.'));
      }
    });




    // Anonymous Sign In Event

    on<AuthAnonymousEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final userCredential =
            await FirebaseAuth.instance.signInAnonymously();

        final user = userCredential.user;
        if (user == null) {
          throw Exception("User is null");
        }

        emit(AuthAuthenticated(message: "User signed in anonymously"));
        
        try {
          final photoUrl = await uploadDefaultProfileImage(user.uid);
          await user.updatePhotoURL(photoUrl);
          await user.updateDisplayName("Anonymous User");
          await user.reload();
        } catch (e) {
          log("PROFILE SETUP ERROR: $e");
        }

      } catch (e) {
        emit(AuthUnauthenticated(errorMessage: e.toString()));
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
