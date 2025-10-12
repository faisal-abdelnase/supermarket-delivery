import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/features/Auth/presentation/view/otp_page.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/custom_text_form_filed.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/enter_phone_number.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  static final phoneAuthId = "/phoneAuthId";

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneCodeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(

        listener: (context, state) {

          if (state is AuthAuthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              HomeView.homeId,
              (route) => false,
            );
            showSnackBarMessage(context, state.message, Colors.green);
          }
          if(state is AuthOtpSent){
            Navigator.of(context).pushNamed(OtpPage.otpPageId);
            showSnackBarMessage(context, state.message, Colors.green);
          }

          else if (state is AuthUnauthenticated) {
            showSnackBarMessage(context, state.errorMessage, Colors.red);
          }
        },

        builder: (context, state) {
          if(state is AuthPhoneLoading){
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
                          authBloc.add(PhoneSignInEvent(phoneNumber: phoneCodeController.text.trim() + phoneController.text.trim(), context: context,),
                          );
                          // Navigator.of(context).pushNamed(OtpPage.otpPageId);
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
