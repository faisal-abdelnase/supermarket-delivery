import 'package:flutter/material.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight, required this.text,
  });

  final double screenWidth;
  final double screenHeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(screenWidth * 0.9, screenHeight * 0.07),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white
      ),
      onPressed: (){}, 
      child: Text(text, 
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),),
      );
  }
}


