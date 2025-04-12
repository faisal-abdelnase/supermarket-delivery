import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/bottom_buttons_to_product_details.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/product_details_body.dart';


class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  static const String productDetailsId = '/productDetailsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            ProductsDetailsBody(),
        
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomButtonsToProductDetails(),
            ),
          ],
        ),
      ),
    );
  }
}

