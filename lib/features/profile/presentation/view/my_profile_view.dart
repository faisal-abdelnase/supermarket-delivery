import 'package:flutter/material.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
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
                  onPressed: (){},
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

