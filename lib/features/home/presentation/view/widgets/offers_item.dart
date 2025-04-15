import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/product_details_view.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/offer_data.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/offer_value.dart';

class OffersItem extends StatefulWidget {
  const OffersItem({super.key});

  @override
  State<OffersItem> createState() => _OffersItemState();
}

class _OffersItemState extends State<OffersItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsView.productDetailsId, arguments: true);
      },
      child: Stack(
        children: [
          
        OfferData(),
        
        Positioned(
            top: 0,
            right: 0,
            child: OfferValue(),
          ),
        ],
      ),
    );
  }
}

