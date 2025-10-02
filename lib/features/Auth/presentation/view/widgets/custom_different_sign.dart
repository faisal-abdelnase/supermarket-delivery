import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';

class CustomDifferentSign extends StatelessWidget {
  const CustomDifferentSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape: CircleBorder(),
            padding: EdgeInsets.all(10)
          ),
          onPressed: (){}, 
          child: Image.asset("assets/images/facebook.png", width: 30, height: 30,)
          ),
    
        // sign with Google
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape: CircleBorder(),
            padding: EdgeInsets.all(10)
          ),
          onPressed: (){
            authBloc.add(GoogleSignUpEvent());
          }, 
          child: Image.asset("assets/images/google.png", width: 30, height: 30,)
          ),
      ],
    );
  }
}