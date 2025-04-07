import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/search_by_filter.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/search_text_field.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Row(
              children: [
                CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/faisal.jpg"),
            ),
    
            SizedBox(width: 16,),
            
            Text("Faisal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            ),

            IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.exit_to_app, size: 30,)),
          ],
        ),

        SizedBox(height: 16,),
    
        Text("Ready To Order Your", 
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold),
          ),
    
          SizedBox(height: 16,),
          Row(
            children: [
              Expanded(child: SearchTextField()),

              SizedBox(width: 16,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  
                ),
                onPressed: (){
                  Navigator.pushNamed(context, SearchByFilter.searchByFilterId);
                }, 
                child: Image.asset("assets/images/settings.png", width: 20, height: 20, color: Colors.white,),),
            ],
          ),
      ],
    );
  }
}

