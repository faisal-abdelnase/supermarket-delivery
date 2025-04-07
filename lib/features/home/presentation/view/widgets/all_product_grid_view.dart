import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/custom_product_item.dart';

class AllProductGridView extends StatelessWidget {
  const AllProductGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8,
          ), 
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        itemBuilder: (context, index){
          return CustomProductItem();
        }),
    );
  }
}