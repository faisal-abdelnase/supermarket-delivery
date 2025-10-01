import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/features/Auth/presentation/view/forgot_password.dart';
import 'package:super_market/features/Auth/presentation/view/sign_up.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_different_sign.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_divider_or.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_from_filed_password.dart';


class SignInBody extends StatefulWidget {
  const SignInBody({super.key,});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {


    bool groupValue = false;
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return SafeArea(
      top: true,
      
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          
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
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sign In Your Account", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),
                              
                      
                      SizedBox(height: 30,),
                      
                      CustomTextFormField(
                        hintText: "Email", 
                        icon: Icons.email, 
                        controller: emailController,
                        validator: (value) => value!.isEmpty ? "Enter your email" : null,
                        ),
                      SizedBox(height: 30,),
                      CustomTextFromFiledPassword(
                        hintText: "Password", 
                        controller: passwordController,
                        validator: (value) => value!.isEmpty ? "Enter your password" : null,
                        ),
                              
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
                              value: true, 
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
                            onPressed: (){
                              Navigator.of(context).pushNamed(ForgotPassword.forgetPasswordId);
                            }, 
                            child: Text("Forgot Password?", 
                            style: TextStyle(color: Colors.blue),),
                            ),
                        ],
                      ),
                      
                      
                      SizedBox(height: 30,),
                              
                      CustomElvatedButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()){

                            authBloc.add(SignInEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ));

                          }
                        },
                        text: "Sign In",),
                      
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

