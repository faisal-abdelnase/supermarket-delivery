import 'package:flutter/material.dart';

showAlertDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text("Reset Your Passowrd!", style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text("You successfully reset your password", style: TextStyle(color: Colors.grey),),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              onPressed: (){}, 
              child: Text("Go To Home")
              ),
          ],
        );
      });
  }