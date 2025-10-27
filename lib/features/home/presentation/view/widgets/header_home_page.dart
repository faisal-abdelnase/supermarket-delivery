import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:super_market/core/utils/shared_preference_function.dart';
import 'package:super_market/features/Auth/presentation/view/type_of_registeration.dart';
import 'package:super_market/features/home/presentation/view/search_by_filter.dart';
import 'package:super_market/features/home/presentation/view/widgets/search_text_field.dart';
import 'package:super_market/features/profile/presentation/manager/cubit/profile_info_cubit.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
        if(state is ProfileInfoSuccess){
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(
                        File(state.userInfoModel.imagePath),
                      ),
                    ),

                    SizedBox(width: 16),

                    Text(
                      state.userInfoModel.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                IconButton(
                  onPressed: () async {
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    await googleSignIn.signOut();
                    await FirebaseAuth.instance.signOut();
                    SharedPreferenceFunction.saveLoggedInState(isLoggedIn: false);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      TypeOfRegisteration.registeration,
                      (route) => false,
                    );
                  },
                  icon: Icon(Icons.exit_to_app, size: 30),
                ),
              ],
            ),

            SizedBox(height: 16),

            Text(
              "Ready To Order Your",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: SearchTextField()),

                SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SearchByFilter.searchByFilterId,
                    );
                  },
                  child: Image.asset(
                    "assets/images/settings.png",
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );

        }
        else if(state is ProfileInfoError){
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        else{
          return Center(child: Icon(
            Icons.warning_amber, 
            size: 50, 
            color: Colors.red,),);
        }
      },
    );
  }
}
