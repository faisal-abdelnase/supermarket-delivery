import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/cart_item.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Row(
                spacing: MediaQuery.of(context).size.width * 0.3,
                children: [
                  CustomArrowBackButton(),
                  Text("My Cart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],

              ),

              CartItem(),
            ],
          ),
        ),
      ),
    );
  }
}

