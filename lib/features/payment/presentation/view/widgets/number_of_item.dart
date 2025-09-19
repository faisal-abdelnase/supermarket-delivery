import 'package:flutter/material.dart';
import 'package:super_market/core/utils/widgets/custom_icon_button.dart';
import 'package:super_market/features/payment/data/model/cart_info_model.dart';

class NumberOfItem extends StatefulWidget {
  const NumberOfItem({
    super.key, required this.cartInfoModel,
  });

  final CartInfoModel cartInfoModel;

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
              if (widget.cartInfoModel.productQuantity > 1) {
                setState(() {
                  widget.cartInfoModel.productQuantity--;
                });
              }
            },
          ),
        
        Text(widget.cartInfoModel.productQuantity.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
        
        CustomIconButton(
          iconSize: 16,
          minSize: Size(20, 20),
          backgroundColor: Colors.blue,
          icon: Icon(Icons.add,color: Colors.white,),
          onPressed: () {
            setState(() {
              widget.cartInfoModel.productQuantity++;
            });
          },
        ),
      ],
    );
  }
}