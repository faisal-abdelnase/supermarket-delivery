import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: MediaQuery.of(context).size.width * 0.3,
      
      children: [
        CustomArrowBackButton(),
    
    Center(
      child: Text(
        'Details',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
      ],
    );
  }
}