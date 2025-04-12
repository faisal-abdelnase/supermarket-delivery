import 'package:flutter/material.dart';
import 'package:super_market_app/features/Auth/presentation/view/otp_page.dart';
import 'package:super_market_app/features/Auth/presentation/view/sign_in.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  static final forgetPasswordId = "/forgetPassword";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomArrowBackButton(),
          
              SizedBox(height: 30,),

              Text("Forgot Your Password", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),

              SizedBox(height: 30,),

              CustomTextFormField(hintText: "Enter Email", icon: Icons.email,),
              SizedBox(height: 30,),
              CustomElvatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(OtpPage.otpPageId);
                },
                screenWidth: screenWidth, 
                screenHeight: screenHeight, 
                text: "Send Code",),
              
              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Go Back To", style: TextStyle(color: Colors.black),),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, SignInPage.signInId);
                    }, 
                    child: Text("Sign in", 
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue
                      ),
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}