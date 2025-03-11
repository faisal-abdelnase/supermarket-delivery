import 'package:flutter/material.dart';

class CustomDifferentSign extends StatelessWidget {
  const CustomDifferentSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    
    
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape: CircleBorder(),
            padding: EdgeInsets.all(10)
          ),
          onPressed: (){}, 
          child: Image.asset("assets/images/google.png", width: 30, height: 30,)
          ),
      ],
    );
  }
}