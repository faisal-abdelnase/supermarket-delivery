import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';


part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoInitial());


  Future<void> fetchProfileInfo() async {
    emit(ProfileInfoLoading());
    try {
        FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;
        if (user != null) {
          
          String? email = user.email;
          String? displayName = user.displayName;
          String? photoURL = user.photoURL;

          emit(ProfileInfoSuccess(email: email, displayName: displayName, photoURL: photoURL));
        } else {
          emit(ProfileInfoError(errorMessage: "No user is currently signed in."));
        }
    } catch (e) {
      emit(ProfileInfoError(errorMessage: e.toString()));
    }
  }


  
}
