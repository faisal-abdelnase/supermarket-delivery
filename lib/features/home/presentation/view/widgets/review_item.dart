import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
    
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/faisal.jpg",),
          ),
    
          Expanded(
            child: Column(
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Faisal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    RatingBarIndicator(
                        rating: 4.5,
                        itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                        ),
                        unratedColor: Colors.blue,
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                    ),
            
                  ],
                ),
            
                Text("This range values are in intervals of 20 because the Range Slider has 5 divisions,", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
