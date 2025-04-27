import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market_app/features/payment/presentation/view/delivery_address_view.dart';
import 'package:super_market_app/core/utils/widgets/card_info.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/custom_list_view_card_info.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/reset_cart.dart';


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
          child: SingleChildScrollView(
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
            
                CardInfo(
                  onPressed: () {
                    Navigator.pushNamed(context, DeliveryAddressView.addressViewID);
                  },
                  prefixIcon: Icons.location_on_outlined, 
                  suffixIcon: Icons.arrow_forward_ios, 
                  text: '80 Banastre Road, Southport,SouthportSouthportSouthportSouthportSouthport',
                  ),
            
                  Text("Payment Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            
                  CardInfo(
                    onPressed: () {
                      
                    },
                  prefixIcon: Icons.payment, 
                  suffixIcon: Icons.arrow_forward_ios, 
                  text: '**** **** **** 1234',
                  ),
            
            
                  Text("Item List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            
                  CustomListViewCardInfo(),

                  ResetCart(),

                  CustomElvatedButton(
                  text: "Place Order", 
                  onPressed: (){
                    
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

