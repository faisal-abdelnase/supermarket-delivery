import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.textButton, required this.textButton2, required this.hiddenButton});

  final String textButton;
  final String textButton2;
  final bool hiddenButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
      
          Row(
            children: [
              Image.asset("assets/images/millk.jpg", width: 50, height: 50,),
      
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Milk", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      "80 Banastre Road, Southport SouthportSouthport",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                  ),


                  SizedBox(height: 8,),


                  Row(
                    spacing: 2,
                    children: [
                      Text("\$11.7", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

                      Text("(2 items)" , style: TextStyle(color: Colors.grey, fontSize: 14),),

                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 30,
                          
                        ),
                      ),

                      Text("Today 10:50 PM" , style: TextStyle(color: Colors.grey, fontSize: 12),),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 8,),

          Divider(color: Colors.grey, thickness: 1, height: 20,),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("#03251", style: TextStyle(color: Colors.blue, fontSize: 14),),
            
                Row(
                  spacing: 10,
                  children: [
                
                    
                    Visibility(
                      visible: hiddenButton,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 219, 235, 248),
                          
                        ),
                        onPressed: (){}, 
                        child: Text(textButton, style: TextStyle(color: Colors.blue),),
                        ),
                    ),
                
                
                            
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        
                      ),
                      onPressed: (){}, 
                      child: Text(textButton2, style: TextStyle(color: Colors.white),),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}