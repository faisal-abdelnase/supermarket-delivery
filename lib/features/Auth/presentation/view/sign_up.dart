import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/core/utils/shared_preference_function.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/features/Auth/presentation/view/widgets/sign_up_body.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';
import 'package:super_market/features/profile/presentation/manager/cubit/profile_info_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static final signUpId = "/signUpPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthAuthenticated) {
            await BlocProvider.of<ProfileInfoCubit>(context).storeProfileInfoLocally();
            SharedPreferenceFunction.saveLoggedInState(isLoggedIn: true);
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
          if(state is AuthLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return SignUpBody();
        },
      ),
    );
  }
}
