import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/offers_item.dart';


class OffersListView extends StatelessWidget {
  const OffersListView({super.key});

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
            return OffersItem();
          }),
      ),
    );
  }
}