import 'package:flutter/material.dart';
import 'package:super_market/features/home/presentation/view/widgets/custom_product_item.dart';

class RecommendedListView extends StatefulWidget {
  const RecommendedListView({
    super.key,
  });

  @override
  State<RecommendedListView> createState() => _RecommendedListViewState();
}

class _RecommendedListViewState extends State<RecommendedListView> {
  
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 240,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index){
            return CustomProductItem();
          }),
      ),
    );
  }
}

