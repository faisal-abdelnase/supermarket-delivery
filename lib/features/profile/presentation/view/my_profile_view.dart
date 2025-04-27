import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/home/presentation/view/home_view.dart';
import 'package:super_market_app/features/profile/presentation/view/widgets/profile_info.dart';
import 'package:super_market_app/features/profile/presentation/view/widgets/profile_user_info.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  static const String myProfileId = "/my profile id";

  @override
  Widget build(BuildContext context) {
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


                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

