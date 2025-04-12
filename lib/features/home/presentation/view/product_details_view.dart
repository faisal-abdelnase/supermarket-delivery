import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/bottom_buttons_to_product_details.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/custom_product_item.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/product_details_header.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  static const String productDetailsId = '/productDetailsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                child: 
                  Column(
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
                        spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Rating :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Icon(Icons.star, color: Colors.yellow, size: 32,),
                        Text("4.5", style: TextStyle(fontSize: 18, color: Colors.grey),),
                      ],
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
                      SizedBox(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index){
                          return CustomProductItem();
                        }),
                    ),

                    SizedBox(height: 50,),
                  
                    ],
                  ),
              ),
            ),
        
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomButtonsToProductDetails(),
            ),
          ],
        ),
      ),
    );
  }
}

