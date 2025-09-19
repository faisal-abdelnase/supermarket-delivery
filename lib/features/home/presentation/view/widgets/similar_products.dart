import 'package:flutter/material.dart';
import 'package:super_market/features/home/presentation/view/widgets/custom_product_item.dart';

class SimilarProducts extends StatelessWidget {
  const SimilarProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: 240,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index){
        return CustomProductItem();
      }),
      );
  }
}

