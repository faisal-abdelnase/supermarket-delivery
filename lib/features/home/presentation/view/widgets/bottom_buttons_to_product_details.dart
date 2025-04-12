import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_icon_button.dart';

class BottomButtonsToProductDetails extends StatelessWidget {
  const BottomButtonsToProductDetails({
    super.key,
  });

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
            backgroundColor: Colors.grey[200]!,
            icon: Icon(Icons.remove),
            onPressed: () {},
          ),
    
          Text("2", style: TextStyle(fontWeight: FontWeight.bold),),
    
          CustomIconButton(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.add,color: Colors.white,),
            onPressed: () {},
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



