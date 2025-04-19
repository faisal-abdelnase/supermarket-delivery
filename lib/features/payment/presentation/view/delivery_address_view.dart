import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/search_location.dart';

class DeliveryAddressView extends StatelessWidget {
  const DeliveryAddressView({super.key});

  static String addressViewID = "/address view id";

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
              children: [
                Row(
                  spacing: MediaQuery.of(context).size.width * 0.2,
                  children: [
                    CustomArrowBackButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    Text("Delivery Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    
                  ],
                ),

                SearchLocation(),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}