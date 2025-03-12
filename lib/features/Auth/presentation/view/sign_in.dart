
import 'package:flutter/material.dart';
import 'package:super_market_app/features/Auth/presentation/view/sign_up.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_different_sign.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_divider_or.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_elvated_button.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_text_from_filed_password.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static final signInId = "/signIn";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

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
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomArrowBackButton(),

              SizedBox(height: 30,),
              
              Expanded(
                
                child: SingleChildScrollView(
                  
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sign In Your Account", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),
                              
                      
                      SizedBox(height: 30,),

                      CustomTextFormField(hintText: "Email", icon: Icons.email,),
                      SizedBox(height: 30,),
                      CustomTextFromFiledPassword(),
                              
                      // Remember me and forgot your password
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text("Remember Me", style: TextStyle(fontSize: 14),),
                              leading: Radio(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: "yes", 
                              groupValue: groupValue, 
                              onChanged: (value){
                                groupValue = value!;
                                setState(() {});
                              },
                              activeColor: Colors.blue,
                              ),
                              horizontalTitleGap: -5,
                            
                            ),
                          ),
                              
                              
                          TextButton(
                            onPressed: (){}, 
                            child: Text("Forgot Password?", 
                            style: TextStyle(color: Colors.blue),),
                            ),
                        ],
                      ),


                      SizedBox(height: 30,),
                              
                      CustomElvatedButton(screenWidth: screenWidth, screenHeight: screenHeight, text: "Sign In",),

                      SizedBox(height: 30,),
                              
                      CustomDividerOR(),

                      SizedBox(height: 30,),
                              
                      CustomDifferentSign(),

                      SizedBox(height: 80,),
                              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't Have An Account?", style: TextStyle(color: Colors.black),),
                          TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, SignUpPage.signUpId);
                            }, 
                            child: Text("Sign up", 
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