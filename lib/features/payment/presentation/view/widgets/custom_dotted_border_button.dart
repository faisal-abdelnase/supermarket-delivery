

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CustomDottedBorderButton extends StatelessWidget {
  const CustomDottedBorderButton({
    super.key, required this.onPressed, required this.text,
  });

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return DottedBorder(

      options: RoundedRectDottedBorderOptions(
          color: Colors.blue,
          strokeWidth: 2,
          dashPattern: [4, 2],
          padding: EdgeInsets.all(0),
          radius: Radius.circular(32),
        
      ),
      
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth * 0.9, screenHeight * 0.07),
          backgroundColor: const Color(0xFFE3F2FD),
          foregroundColor: Colors.blue,
          
        ),
        onPressed: onPressed, 
        child: Text(text, 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),),
        ),
    );
  }
}

