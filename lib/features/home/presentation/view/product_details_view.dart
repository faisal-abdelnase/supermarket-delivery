import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/product_details_header.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  static const String productDetailsId = '/productDetailsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            ProductDetailsHeader()
          ],
        ),
      ),
    );
  }
}

