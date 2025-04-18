import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
      children: [
        CustomArrowBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
    
    Text(
      'Details',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),


    IconButton(
      onPressed: (){}, 
      icon: Icon(Icons.shopping_cart_checkout_sharp, color: Colors.blue, size: 28,))
      ],
    );
  }
}