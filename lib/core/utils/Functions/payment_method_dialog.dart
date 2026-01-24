import 'package:flutter/material.dart';
import 'package:super_market/features/payment/presentation/view/checkout_view.dart';

showAlertDialogPayment(BuildContext context, String paymentMethod){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          icon: Icon(Icons.warning_outlined, size: 64, color: Colors.red,),
          title: RichText(
            textAlign: TextAlign.center,
            text: 
              TextSpan(text: "Are You Sure you want to use\t\t",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(text: paymentMethod,
                style: TextStyle(
                  color: Colors.blue,
                )
                ),
              ],
              )),

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



  Future<bool> confirmOrderDialog(BuildContext context) async{

      final confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text("Confirm Order", textAlign: TextAlign.center,),
              content: const Text("Are you sure you want to place this order?",  
              textAlign: TextAlign.center,),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 219, 235, 248),
                  ),
                onPressed: (){
                  Navigator.of(dialogContext).pop(false);
                }, 
                child: Text("No", style: TextStyle(color: Colors.blue),),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                onPressed: (){
                  Navigator.of(dialogContext).pop(true);
                }, 
                child: Text("Yes", style: TextStyle(color: Colors.white),),
                ),
              ],
            );
          },
        );

        return confirmed ?? false;
          
        

    }