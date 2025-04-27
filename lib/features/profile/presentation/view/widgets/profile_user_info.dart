import 'package:flutter/material.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/faisal.jpg"),
            ),
    
            const SizedBox(height: 16,),
    
            Text("Faisl Abdelnasser", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text("faisal12abelnasser@gmail.com", style: TextStyle(color: Colors.grey),)
        
          ],
        ),
      
    );
  }
}