import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/features/Auth/presentation/view/sign_in.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_different_sign.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_divider_or.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_from_filed_password.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/rich_text_to_agree_radio.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({
    super.key,});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {


  bool acceptCondition = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return SafeArea(
      top: true,
      
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomArrowBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
    
            SizedBox(height: 30,),
            
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sign Up Your Account", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),
                  
                      SizedBox(height: 30,),
                      
                      CustomTextFormField(
                        hintText: "Full Name", 
                        icon: Icons.account_circle, 
                        controller: userNameController,
                        validator: (value) => value!.isEmpty ? "Enter your full name" : null,
                        ),
    
                      SizedBox(height: 20,),
    
                      CustomTextFormField(
                        hintText: "Email", 
                        icon: Icons.email, 
                        controller: emailController,
                        validator: (value) => value!.isEmpty ? "Enter your email" : null,
                        ),
                      SizedBox(height: 20,),
    
                      CustomTextFromFiledPassword(
                        hintText: "Password", 
                        controller: passwordController,
                        validator: (value) => value!.isEmpty ? "Enter your password" : null,
                        ),
    
                      SizedBox(height: 20,),
    
                      CustomTextFromFiledPassword(
                        hintText: "Confirm Password", 
                        controller: confirmPasswordController,
                        validator: (value) => value!.isEmpty ? "Enter your confirm password" : null,
                        ),
    
                      Row(
                        children: [
                          Radio(
                            value: true, 
                            groupValue: acceptCondition, 
                            onChanged: (value){
                              acceptCondition = value!;
                              setState(() {});
                            },
                            activeColor: Colors.blue,
                            ),
                      
                            RichTextToAgreeRadio()
                        ],
                      ),
                  
                      SizedBox(height: 30,),
                      
                      CustomElvatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate() && acceptCondition) {
                              if (passwordController.text != confirmPasswordController.text) {
                                showSnackBarMessage(context, "Password does not match", Colors.red);
                              } else {
                                authBloc.add(SignUpEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  userName: userNameController.text.trim(),
                                  
                                ));


                              }
                          } else if (!acceptCondition) {
                            showSnackBarMessage(context, "Please accept the terms", Colors.red);
                          }
                        },
                        text: "Sign Up",
                        ),
                  
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
              ),
            )
          ],
        ),
      ),
    );
  }
}





