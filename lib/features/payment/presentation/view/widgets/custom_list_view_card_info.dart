import 'package:flutter/material.dart';
import 'package:super_market_app/features/payment/data/model/cart_info_model.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/cart_item.dart';

class CustomListViewCardInfo extends StatefulWidget {
  const CustomListViewCardInfo({
    super.key,
  });

  @override
  State<CustomListViewCardInfo> createState() => _CustomListViewCardInfoState();
}

class _CustomListViewCardInfoState extends State<CustomListViewCardInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16),
        shrinkWrap: true,
        itemCount: CartInfoModel.cartInfoList.length,
        itemBuilder: (context, index) {
          final item = CartInfoModel.cartInfoList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Dismissible(
              key: Key(item.id), // make sure 'id' is unique
              direction: DismissDirection.horizontal, // swipe to the right
              onDismissed: (direction) {
                setState(() {
                  CartInfoModel.cartInfoList.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.poductName} deleted')),
                );
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    Icon(Icons.delete, color: Colors.white),
                  ],
                )
              ),
              child: CartItem(cartInfoModel: item),
            ),
          );
        },
      );
  }
}


