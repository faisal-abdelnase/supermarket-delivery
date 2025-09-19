import 'package:flutter/material.dart';
import 'package:super_market/features/payment/data/model/cart_info_model.dart';
import 'package:super_market/features/payment/presentation/view/widgets/number_of_item.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key, required this.cartInfoModel,
  });

  final CartInfoModel cartInfoModel;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        spacing: 16,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(cartInfoModel.image,),
          ),
    
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cartInfoModel.poductName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star, color: Colors.amber,),
                  
                        Text("4.5", style: TextStyle(fontSize: 12, color: Colors.grey),),
                      ],
                    ),
            
                  ],
                ),
                Text(cartInfoModel.description, style: TextStyle(fontSize: 16, color: Colors.grey ,fontWeight: FontWeight.w500),),
    
    
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cartInfoModel.productPrice, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
    
                    NumberOfItem(cartInfoModel: cartInfoModel,),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

