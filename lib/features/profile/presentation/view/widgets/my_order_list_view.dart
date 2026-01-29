import 'package:flutter/material.dart';
import 'package:super_market/features/profile/data/model/order_item.dart';
import 'package:super_market/features/profile/presentation/view/widgets/order_info.dart';

class MyOrderListView extends StatelessWidget {
  const MyOrderListView({super.key, required this.textButton, required this.textButton2, required this.hiddenButton, required this.orders});

  final String textButton;
  final String textButton2;
  final bool hiddenButton;
  final List<OrderItem> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: OrderInfo(textButton: textButton, textButton2: textButton2, hiddenButton: hiddenButton, order: orders[index],),
        );
      });
  }
}