import 'package:flutter/material.dart';
import 'package:super_market/features/payment/presentation/view/checkout_view.dart';

showAlertDialogPayment(BuildContext context){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          icon: Icon(Icons.warning_outlined, size: 64, color: Colors.red,),
          title: Text("Are You Sure you want to use this card", 
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),),

          actions: [

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 219, 235, 248),
              ),
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: Text("No", style: TextStyle(color: Colors.blue),),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            onPressed: (){
              Navigator.pushReplacementNamed(context, CheckoutView.checkoutId);
            }, 
            child: Text("Yes", style: TextStyle(color: Colors.white),),
            ),

            
          ],
        );
      } );
  }