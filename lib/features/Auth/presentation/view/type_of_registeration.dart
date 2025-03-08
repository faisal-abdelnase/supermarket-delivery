import 'package:flutter/material.dart';

class TypeOfRegisteration extends StatelessWidget {
  const TypeOfRegisteration({super.key});

  static final registeration = "/typeOfRegisteration";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/register.jpeg", ),

          Column(
            children: [
              Text("Join Us Or Sign in", 
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),),

          SizedBox(height: 8,),
          Text("We have the best products in all branches\n\t\t\t\t\t\t\t\t\t\t\t\t and our service is 24 hours",
          maxLines: 2,
          style: TextStyle(
            color: Colors.grey,
          ),),
            ],
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  
                ),
                onPressed: (){}, 
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Sign up"),
                )
                ),

                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 228, 227, 227),
                  foregroundColor: Colors.black
                ),
                onPressed: (){}, 
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Sign in"),
                )
                ),
            ],
          )

        ],
      ),
    );
  }
}