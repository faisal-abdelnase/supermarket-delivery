import 'package:flutter/material.dart';
import 'package:super_market/features/Auth/presentation/view/otp_page.dart';
import 'package:super_market/features/Auth/presentation/view/sign_in.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static final forgetPasswordId = "/forgetPassword";

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomArrowBackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          
              SizedBox(height: 30,),

              Text("Forgot Your Password", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),

              SizedBox(height: 30,),

              CustomTextFormField(
                hintText: "Enter Email", 
                icon: Icons.email, 
                controller: emailController,
                validator: (value) => value!.isEmpty ? "Enter your email" : null,
                ),
              SizedBox(height: 30,),
              CustomElvatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(OtpPage.otpPageId);
                },
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