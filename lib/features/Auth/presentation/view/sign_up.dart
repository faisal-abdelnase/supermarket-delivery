import 'package:flutter/material.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_different_sign.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_divider_or.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_elvated_button.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_text_from_filed_password.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/rich_text_to_agree_radio.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static final signUpId = "/signUpPage";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String groupValue = "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: true,
        
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

              Row(
                children: [
                  Radio(
                    value: "agree", 
                    groupValue: groupValue, 
                    onChanged: (value){
                      groupValue = value!;
                      setState(() {});
                    },
                    activeColor: Colors.blue,
                    ),

                    RichTextToAgreeRadio()
                ],
              ),

              CustomElvatedButton(screenWidth: screenWidth, screenHeight: screenHeight),

              CustomDividerOR(),

              CustomDifferentSign(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have An Account?", style: TextStyle(color: Colors.black),),
                  TextButton(
                    onPressed: (){}, 
                    child: Text("Sign in", 
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue
                      ),
                    ),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}







