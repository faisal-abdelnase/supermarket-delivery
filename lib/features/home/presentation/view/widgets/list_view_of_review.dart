import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/review_item.dart';

class ListViewOfReview extends StatefulWidget {
  const ListViewOfReview({
    super.key,
  });

  @override
  State<ListViewOfReview> createState() => _ListViewOfReviewState();
}

class _ListViewOfReviewState extends State<ListViewOfReview> {

  int numberOfReviews = 10;
  String textButton = "See More";
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.builder(
          
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: numberOfReviews,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ReviewItem(),
            );
          }),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.withValues(alpha: 0.3), Colors.black.withValues(alpha: 0.4)], 
                begin: Alignment.topCenter, 
                end: Alignment.bottomCenter,
                stops: [0.5, 1],
                ),


                borderRadius: BorderRadius.circular(8)
            ),
            child: TextButton(
              
              onPressed: (){

                
                setState(() {
                  if(numberOfReviews < 20){
                    numberOfReviews += 10;
                    if(numberOfReviews == 20){
                      textButton = "See Less";
                    }
                  }

                  else{
                    setState(() {
                      numberOfReviews = 10;
                      textButton = "See More";
                    });
                  }
                });

              }, 
              child: Text(textButton, style: TextStyle(color: Colors.black),)
              ),
          )
      ],
    );
  }
}


