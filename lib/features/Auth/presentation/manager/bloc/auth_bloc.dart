import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
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
  }
}
