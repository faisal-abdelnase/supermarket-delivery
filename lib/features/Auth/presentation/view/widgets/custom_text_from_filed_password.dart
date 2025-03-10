import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFromFiledPassword extends StatefulWidget {
  const CustomTextFromFiledPassword({super.key});

  @override
  State<CustomTextFromFiledPassword> createState() => _CustomTextFromFiledPasswordState();
}

class _CustomTextFromFiledPasswordState extends State<CustomTextFromFiledPassword> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          ),
        fillColor: Colors.grey[200],
        filled: true,
        suffixIcon: IconButton(
          onPressed: (){
            obscureText = obscureText ? false : true;
            setState(() {});
          }, 
          icon: obscureText ? Icon(FontAwesomeIcons.solidEyeSlash) : Icon(FontAwesomeIcons.solidEye)
          ),
        suffixIconColor: Colors.blue,
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.transparent)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
            )
        )
      ),
    );
  }
}