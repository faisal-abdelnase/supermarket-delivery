import 'package:flutter/material.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(screenWidth * 0.9, screenHeight * 0.07),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
      ),
      onPressed: (){}, 
      child: Text("Sign Up", 
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),),
      );
  }
}


