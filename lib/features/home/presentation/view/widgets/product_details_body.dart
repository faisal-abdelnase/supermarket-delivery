import 'package:flutter/material.dart';
import 'package:super_market/features/home/data/model/products_model.dart';
import 'package:super_market/features/home/presentation/view/widgets/add_comment.dart';
import 'package:super_market/features/home/presentation/view/widgets/list_view_of_review.dart';
import 'package:super_market/features/home/presentation/view/widgets/product_details_header.dart';
import 'package:super_market/features/home/presentation/view/widgets/similar_products.dart';
import 'package:super_market/features/home/presentation/view/widgets/stars_rating.dart';

class ProductsDetailsBody extends StatefulWidget {
  const ProductsDetailsBody({
    super.key,
  });

  @override
  State<ProductsDetailsBody> createState() => _ProductsDetailsBodyState();
}

class _ProductsDetailsBodyState extends State<ProductsDetailsBody> {

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {

    final product = ModalRoute.of(context)!.settings.arguments as ProductsModel;
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
                    image: NetworkImage(product.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ),


          Visibility(
            visible: product.isOffers,
            child: Row(
              spacing: 20,
              children: [
                Text("discount %50", 
                style: TextStyle(
                  color: Colors.red, 
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                ),
                ),

                Text("\$${product.price}",

                style: TextStyle(
                  color: Colors.grey, 
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 3,
                  decorationColor: Colors.grey,
                ),
                ),
              ],
            )
            ),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.name, 
              style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold,
                ),),


              Text("\$${product.price}", 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                ),),

                IconButton(
                  onPressed: (){
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  }, 
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey, 
                    size: 30,),),
                
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      
              Text(product.description, 
              style: TextStyle(color: Colors.grey),),
            ],
          ),
      
      
          StarsRating(rating: product.rating,),
      
          
      
          Text("Similar products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          SimilarProducts(),


          Text("Add Comment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

          AddComment(),
      
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

