import 'package:flutter/material.dart';
import 'package:super_market/core/utils/widgets/custom_icon_button.dart';

class BottomButtonsToProductDetails extends StatefulWidget {
  const BottomButtonsToProductDetails({
    super.key,
  });

  @override
  State<BottomButtonsToProductDetails> createState() => _BottomButtonsToProductDetailsState();
}

class _BottomButtonsToProductDetailsState extends State<BottomButtonsToProductDetails> {

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomIconButton(
            iconSize: 24,
            minSize: Size(30, 30),
            backgroundColor: Colors.grey[200]!,
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
            iconSize: 24,
            minSize: Size(30, 30),
            backgroundColor: Colors.blue,
            icon: Icon(Icons.add,color: Colors.white,),
            onPressed: () {
              setState(() {
                quantity++;
              });
            },
          ),
    
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              fixedSize: Size(150, 50),
            ),
            onPressed: (){}, 
            child: Text("Add To Cart")),
        ],
      ),
    );
  }
}



