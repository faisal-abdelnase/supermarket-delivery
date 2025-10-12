import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  static final otpPageId = "/otpPageId";

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();
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
          } else if (state is AuthUnauthenticated) {
            showSnackBarMessage(context, state.errorMessage, Colors.red);
          }
        },
        builder: (context, state) {
          if(state is AuthOtpLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return SafeArea(
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

                  SizedBox(height: 30),

                  Text(
                    "Enter Your OTP",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),

                  SizedBox(height: 50),

                  PinCodeTextField(
                    controller: otpController,
                    appContext: context,
                    length: 6,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      inactiveColor: Colors.grey,
                      inactiveFillColor: Colors.grey,
                      fieldWidth: 50,
                    ),

                    showCursor: false,
                  ),

                  SizedBox(height: 50),
                  CustomElvatedButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed(ResetPassowrd.resetPasswordId);
                      log("OTP Code: ${otpController.text}");
                      authBloc.add(AuthOtpSentEvent(otpCode: otpController.text),);
                      
                    },
                    text: "verify",
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
