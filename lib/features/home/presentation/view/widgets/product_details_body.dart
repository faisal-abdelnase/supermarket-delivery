import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/list_view_of_review.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/product_details_header.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/similar_products.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/stars_rating.dart';

class ProductsDetailsBody extends StatelessWidget {
  const ProductsDetailsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          ProductDetailsHeader(),
      
          AspectRatio(
            aspectRatio: 2/1,
            child: Container(
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/images/millk.jpg",),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Milk", 
              style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold,
                ),),
              Text("\$20", 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                ),),
                
            ],
          ),
      
      
          StarsRating(),
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      
              Text("This range values are in intervals of 20 because the Range Slider has 5 divisions, from 0 to 100. This means are values are split between 0, 20, 40, 60, 80, and 100. The range values are initialized with 40 and 80 in this demo.", 
              style: TextStyle(color: Colors.grey),),
            ],
          ),
      
          Text("Similar products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          SimilarProducts(),
      
          Row(
            spacing: 10,
            children: [
              Text("Review", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text("(99 Reviews)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),),
            ],
          ),
      
          ListViewOfReview(),
      
      
          SizedBox(height: 50,),
      
        ],
      ),
    );

    
  }
}

