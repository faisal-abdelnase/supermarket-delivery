import 'package:flutter/material.dart';
import 'package:super_market/features/profile/data/model/order_item.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.textButton, required this.textButton2, required this.hiddenButton, required this.order});

  final String textButton;
  final String textButton2;
  final bool hiddenButton;
  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: order.items.length,
      itemBuilder: (context, index){
      return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
      
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    order.items[index].image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Icon(Icons.broken_image, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(order.items[index].poductName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      order.items[index].description,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),


                  SizedBox(height: 8,),


                  Row(
                    children: [
                      Text("\$${order.items[index].productPrice}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      SizedBox(width: 8),
                      Text("(${order.items[index].productQuantity})" , style: TextStyle(color: Colors.grey, fontSize: 14),),
                      SizedBox(width: 8),
                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("Today 10:50 PM" , style: TextStyle(color: Colors.grey, fontSize: 12),),
                    ],
                  ),
                ],
              ),
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
                Text("#${order.orderId}", style: TextStyle(color: Colors.blue, fontSize: 14),),
            
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                    SizedBox(width: 10),
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

    });  
    
    }
}