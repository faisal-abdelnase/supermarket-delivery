import 'package:flutter/material.dart';
import 'package:super_market_app/features/Auth/presentation/view/sign_in.dart';
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
    TextEditingController passwordController = TextEditingController();
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

              SizedBox(height: 30,),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sign Up Your Account", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),

                      SizedBox(height: 30,),
                      
                      CustomTextFormField(hintText: "Full Name", icon: Icons.account_circle,),
                      SizedBox(height: 20,),
                      CustomTextFormField(hintText: "Email", icon: Icons.email,),
                      SizedBox(height: 20,),
                      CustomTextFromFiledPassword(hintText: "Password", controller: passwordController,),
                      
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

                      SizedBox(height: 30,),
                      
                      CustomElvatedButton(
                        onPressed: () {},
                        screenWidth: screenWidth, 
                        screenHeight: screenHeight, 
                        text: "Sign Up",),
                      SizedBox(height: 30,),
                      CustomDividerOR(),
                      SizedBox(height: 30,),
                      CustomDifferentSign(),
                      SizedBox(height: 80,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already Have An Account?", style: TextStyle(color: Colors.black),),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}







