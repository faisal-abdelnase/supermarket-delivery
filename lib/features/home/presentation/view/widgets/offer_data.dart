// import 'package:flutter/material.dart';

// class OfferData extends StatelessWidget {
//   const OfferData({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//     width: 120,
//     margin: EdgeInsets.symmetric(horizontal: 8,),
//     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       color: Colors.grey[200],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Icon(Icons.star, color: Colors.amber,),
//             Text("4.5", style: TextStyle(fontSize: 12, color: Colors.grey),),
//           ],
//         ),
      
//         Center(
//           child: Container(
//             width: 70,
//             height: 80,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               image: DecorationImage(
//                 image: AssetImage("assets/images/millk.jpg",),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//         ),
      
//         Text("Milk", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//         Text("1.5 L", style: TextStyle(fontSize: 14, color: Colors.grey),),
      
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("\$5", 
//             style: TextStyle(
//               fontSize: 14, 
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//               decoration: TextDecoration.lineThrough,
//               decorationThickness: 3,
//               decorationColor: Colors.grey,
//               ),),
          
//               Text("\$2", 
//               style: TextStyle(
//               fontSize: 14, 
//               fontWeight: FontWeight.bold,)),
            
//           ],
//         ),
//       ],
//     ),
//           );
//   }
// }

