import 'package:flutter/material.dart';
import 'package:super_market/features/profile/presentation/view/widgets/order_info.dart';

class MyOrderListView extends StatelessWidget {
  const MyOrderListView({super.key, required this.textButton, required this.textButton2, required this.hiddenButton});

  final String textButton;
  final String textButton2;
  final bool hiddenButton;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: OrderInfo(textButton: textButton, textButton2: textButton2, hiddenButton: hiddenButton,),
        );
      });
  }
}