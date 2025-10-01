import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/sign_in_body.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static final signInId = "/signIn";

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
            
          } else if (state is AuthUnauthenticated) {
            showSnackBarMessage(context, state.errorMessage, Colors.red);
          }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return SignInBody();
        },
      ),
    );
  }
}
