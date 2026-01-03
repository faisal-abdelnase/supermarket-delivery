import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/Auth/presentation/manager/cubit/phone_auth_cubit.dart';
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
  late TextEditingController userNameController;
  late TextEditingController phoneController;
  late TextEditingController phoneCodeController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    userNameController = TextEditingController();
    phoneController = TextEditingController();
    phoneCodeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    phoneCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<PhoneAuthCubit>(context);
    return Scaffold(
      body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(

        listener: (context, state) {

          if(state is PhoneAuthCodeSent){
            Navigator.of(context).pushNamed(OtpPage.otpPageId);
            showSnackBarMessage(context, "OTP sent successfully", Colors.green);
          }
          else if(state is PhoneAuthError){
            showSnackBarMessage(context, state.errorMessage, Colors.red);
          }
        },

        builder: (context, state) {
          if(state is PhoneAuthLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomArrowBackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    SizedBox(height: 30),

                    Text(
                      "Enter Your Phone Number",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    SizedBox(height: 50),

                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      hintText: "Full Name",
                      icon: Icons.account_circle,
                      controller: userNameController,
                      validator: (value) =>
                          value!.isEmpty ? "Enter your full name" : null,
                    ),

                    SizedBox(height: 20),

                    EnterPhoneNumber(
                      phoneController: phoneController,
                      countryCodeController: phoneCodeController,
                      validator: (value) => value!.isEmpty ? "code?" : null,
                    ),

                    SizedBox(height: 50),

                    CustomElvatedButton(
                      text: "Next",
                      onPressed: () {
                        if (formKey.currentState!.validate() && phoneCodeController.text.isNotEmpty) {
                          log("Phone Number: ${phoneCodeController.text.trim() + phoneController.text.trim()}",);
                        
                          authBloc.signInWithPhone(phoneNumber: phoneCodeController.text.trim() + phoneController.text.trim(), userName: userNameController.text.trim());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
