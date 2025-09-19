import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:super_market/features/Auth/presentation/view/reset_passowrd.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  static final otpPageId = "/otpPageId";

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

              Text("Enter Your OTP", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),

              SizedBox(height: 50,),

              

              PinCodeTextField(
                
                appContext: context,
                length: 4,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  inactiveColor: Colors.grey,
                  inactiveFillColor: Colors.grey,
                  fieldWidth: 70,
                  
                ),

                showCursor: false,
              ),

              
              SizedBox(height: 50,),
              CustomElvatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ResetPassowrd.resetPasswordId);
                },
                text: "verify",),
              
              SizedBox(height: 30,),

              
            ],
          ),
        ),
      ),
    );
  }

  
}