import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/checkout_info.dart';


class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  static const String checkoutId = "/checkout id";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: MediaQuery.of(context).size.width * 0.3,
                children: [
                  CustomArrowBackButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Text("Checkout", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
          
              ),


              Text("Delivery Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

              ChekoutInfo(
                prefixIcon: Icons.location_on_outlined, 
                suffixIcon: Icons.arrow_forward_ios, 
                text: '80 Banastre Road, Southport,SouthportSouthportSouthportSouthportSouthport',
                ),

                Text("Payment Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                ChekoutInfo(
                prefixIcon: Icons.payment, 
                suffixIcon: Icons.arrow_forward_ios, 
                text: '**** **** **** 1234',
                ),


                Text("Item List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}

