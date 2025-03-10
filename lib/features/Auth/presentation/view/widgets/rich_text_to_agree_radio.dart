import 'package:flutter/material.dart';

class RichTextToAgreeRadio extends StatelessWidget {
  const RichTextToAgreeRadio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "I agree to the ",
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: "terms",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline
              ),
            ),
    
    
            TextSpan(
            text: " & ",
            style: TextStyle(
              color: Colors.black,
              
              ),
            ),
    
    
            TextSpan(
            text: "conditions",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline
              ),
            ),
        ],
        ));
  }
}