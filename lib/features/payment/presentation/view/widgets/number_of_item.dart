import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_icon_button.dart';

class NumberOfItem extends StatefulWidget {
  const NumberOfItem({
    super.key,
  });

  @override
  State<NumberOfItem> createState() => _NumberOfItemState();
}

class _NumberOfItemState extends State<NumberOfItem> {

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          iconSize: 16,
          minSize: Size(20, 20),
            backgroundColor: Colors.grey[300]!,
            icon: Icon(Icons.remove),
            onPressed: () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                });
              }
            },
          ),
        
        Text(quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
        
        CustomIconButton(
          iconSize: 16,
          minSize: Size(20, 20),
          backgroundColor: Colors.blue,
          icon: Icon(Icons.add,color: Colors.white,),
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
        ),
      ],
    );
  }
}