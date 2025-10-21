import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:super_market/constant.dart';
import 'package:super_market/features/profile/data/model/user_info.dart';


part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoInitial());


  fetchProfileInfo() {
    try {
        if(isUserInfoStoredLocally()){
          var usrBox = Hive.box<UserInfoModel>(kProfileBox);
          FirebaseAuth auth = FirebaseAuth.instance;
          User? user = auth.currentUser;
          if (user != null) {
            var userInfo = usrBox.get(user.uid);
            emit(ProfileInfoSuccess(userInfoModel: userInfo!));
          }
        } 
    } catch (e) {
      emit(ProfileInfoError(errorMessage: e.toString()));
    }
  }


  storeProfileInfoLocally() {
    try {
        
        if(!isUserInfoStoredLocally()){
          var usrBox = Hive.box<UserInfoModel>(kProfileBox);
          FirebaseAuth auth = FirebaseAuth.instance;
          User? user = auth.currentUser;
          if (user != null) {
            
            String name = user.displayName!;
            String? email = user.email;
            String imagePath = user.photoURL!;

            var userInfo = UserInfoModel(
              name: name,
              email: email,
              imagePath: imagePath,
            );

            usrBox.put(user.uid, userInfo);
            emit(ProfileInfoSuccess(userInfoModel: userInfo));

          }
        
        }
    } catch (e) {
      emit(ProfileInfoError(errorMessage: e.toString()));
    }
  }


  bool isUserInfoStoredLocally() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) return false;
    var usrBox = Hive.box<UserInfoModel>(kProfileBox);
    return usrBox.containsKey(user.uid);
  }


  
}
