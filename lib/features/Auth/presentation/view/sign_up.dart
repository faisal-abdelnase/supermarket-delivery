import 'package:flutter/material.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_text_from_filed_password.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static final signUpId = "/signUpPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomArrowBackButton(),
              
              Text("Sign Up Your Account", 
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900
              ),),

              CustomTextFormField(hintText: "Full Name", icon: Icons.account_circle,),
              CustomTextFormField(hintText: "Email", icon: Icons.email,),
              CustomTextFromFiledPassword(),
            ],
          ),
        ),
      ),
    );
  }
}



