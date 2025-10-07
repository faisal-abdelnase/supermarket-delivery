import 'package:flutter/material.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/Auth/presentation/view/otp_page.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/enter_phone_number.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  static final phoneAuthId = "/phoneAuthId";

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  

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

              Text("Enter Your Phone Number", 
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                      ),),

              SizedBox(height: 50,),

              CustomTextFormField(
                keyboardType: TextInputType.name,
                  hintText: "Full Name", 
                  icon: Icons.account_circle, 
                  controller: userNameController,
                  validator: (value) => value!.isEmpty ? "Enter your full name" : null,
                  ),

              SizedBox(height: 20,),

              EnterPhoneNumber(phoneController: phoneController),

              SizedBox(height: 50,),

              CustomElvatedButton(
                text: "Next",
                onPressed: () {
                  Navigator.of(context).pushNamed(OtpPage.otpPageId);
                },
              )

            ]
          )
        )
        )

    );
  }
}

