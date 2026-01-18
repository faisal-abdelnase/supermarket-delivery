import 'package:flutter/material.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton({
    super.key, required this.text, required this.onPressed, this.isloading = false,
  });

  
  final String text;
  final void Function() onPressed;
  final bool isloading;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(screenWidth * 0.9, screenHeight * 0.07),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
      ),
      onPressed: onPressed, 
      child: isloading ? CircularProgressIndicator(color: Colors.white,) : Text(text, 
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),),
      );
  }
}


