import 'package:flutter/material.dart';
import 'package:super_market/core/utils/Functions/reset_passwor_dialog.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_from_filed_password.dart';

class ResetPassowrd extends StatelessWidget {
  const ResetPassowrd({super.key});

  static final resetPasswordId = "/resetPassword";

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
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

              Text("Reset Your Password", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),

              SizedBox(height: 30,),

              CustomTextFromFiledPassword(hintText: " New Password", controller: passwordController,),
              SizedBox(height: 30,),
              CustomTextFromFiledPassword(hintText: "confirm Password", controller: confirmPasswordController,),
              SizedBox(height: 30,),
              CustomElvatedButton(
                onPressed: () {
                  if(passwordController.text.isEmpty || passwordController.text.isEmpty){
                    showSnackBarMessage(context, "Please fill all fields");
                  }

                  else if(passwordController.text != confirmPasswordController.text){
                    showSnackBarMessage(context, "Password does not match");
                  }

                  else if(passwordController.text == confirmPasswordController.text){
                    showAlertDialog(
                      context,
                      (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/homeView");
                      }
                      );
                  }
                },
                text: "Reset Password",),
              
              SizedBox(height: 30,),

            
            ],
          ),
        ),
      ),
    );
  }
}