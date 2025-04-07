import 'package:flutter/material.dart';
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
    return Stack(
      children: [
        
      OfferData(),
      
      Positioned(
          top: 0,
          right: 0,
          child: OfferValue(),
        ),
      ],
    );
  }
}

