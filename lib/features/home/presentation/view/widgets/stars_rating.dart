import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarsRating extends StatelessWidget {
  const StarsRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 12,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Rating :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          Icon(Icons.star, color: Colors.amber, size: 32,),
          Text("4.5", style: TextStyle(fontSize: 18, color: Colors.grey),),
        ],
        ),
    
        RatingBar.builder(
          glow: true,
          glowColor: Colors.blue,
          unratedColor: Colors.blue,
          initialRating: 2,
          itemSize: 30,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        )
      ],
    );
  }
}

