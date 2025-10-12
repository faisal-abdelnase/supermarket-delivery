import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/sign_up_body.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static final signUpId = "/signUpPage";

  @override
  Widget build(BuildContext context) {
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

          // else if(state is AuthOtpSent){
          //   Navigator.of(context).pushNamed(OtpPage.otpPageId);
          //   showSnackBarMessage(context, "Verification code sent to phone number", Colors.green);
          // }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return SignUpBody();
        },
      ),
    );
  }
}
