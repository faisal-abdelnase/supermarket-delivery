import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:super_market/core/utils/shared_preference_function.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/features/Auth/presentation/view/type_of_registeration.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';
import 'package:super_market/features/profile/presentation/view/widgets/profile_info.dart';
import 'package:super_market/features/profile/presentation/view/widgets/profile_user_info.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  static const String myProfileId = "/my profile id";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: MediaQuery.of(context).size.width * 0.2,
                  children: [
                    CustomArrowBackButton(onPressed: () {
                      Navigator.pushReplacementNamed(context, HomeView.homeId);
                    }),
                    Text("My Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  ],
                ),

                

                ProfileUserInfo(),
                ProfileInfo(),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                          fixedSize: Size(screenWidth * 0.9, screenHeight * 0.07),
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.blue
                        ),
                  onPressed: () async{
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    await googleSignIn.signOut();
                    await FirebaseAuth.instance.signOut();
                    SharedPreferenceFunction.saveLoggedInState(isLoggedIn: false);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      TypeOfRegisteration.registeration,
                      (route) => false,
                    );
                  },
                  label: Text("Logout", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),),
                  icon: Icon(Icons.exit_to_app, size: 30, color: Colors.blue,),
                  )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

