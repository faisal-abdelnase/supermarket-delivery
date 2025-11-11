import 'package:flutter/material.dart';
import 'package:super_market/features/home/data/model/products_model.dart';
import 'package:super_market/features/home/presentation/view/product_details_view.dart';
import 'package:super_market/features/home/presentation/view/widgets/custom_product_item.dart';
import 'package:super_market/features/home/presentation/view/widgets/offer_value.dart';

class OffersItem extends StatefulWidget {
  const OffersItem({super.key, required this.productsModel});

  final ProductsModel productsModel;
  

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
          
        AspectRatio(
          aspectRatio: 0.7,
          child: CustomProductItem(productModel: widget.productsModel,)),
        
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

