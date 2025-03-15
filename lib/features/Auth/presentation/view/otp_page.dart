import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_elvated_button.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  static final otpPageId = "/otpPageId";

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
                  
                },
                screenWidth: screenWidth, 
                screenHeight: screenHeight, 
                text: "verify",),
              
              SizedBox(height: 30,),

              
            ],
          ),
        ),
      ),
    );
  }
}