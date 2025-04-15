import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/product_details_view.dart';

class CustomProductItem extends StatefulWidget {
  const CustomProductItem({
    super.key,
  });

  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsView.productDetailsId, arguments: false);
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 8,),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.star, color: Colors.amber,),
          
                Text("4.5", style: TextStyle(fontSize: 12, color: Colors.grey),),
              ],
            ),
          
            Center(
              child: Container(
                width: 70,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/images/millk.jpg",),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          
            Text("Milk", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Text("1.5 L", style: TextStyle(fontSize: 14, color: Colors.grey),),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$1.5", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: (){
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  }, 
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey, 
                    size: 20,),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}