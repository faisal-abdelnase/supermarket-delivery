import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/Auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:super_market/features/Auth/presentation/view/phone_auth.dart';

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
          onPressed: (){
            Navigator.pushNamed(context, PhoneAuth.phoneAuthId);
          }, 
          child: Icon(Icons.phone, color: Colors.black, size: 30,)
          ),
    
        // sign with Google
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape: CircleBorder(),
            padding: EdgeInsets.all(10)
          ),
          onPressed: (){
            authBloc.add(GoogleSignInEvent());
          }, 
          child: Image.asset("assets/images/google.png", width: 30, height: 30,)
          ),
      ],
    );
  }
}