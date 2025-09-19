import 'package:flutter/material.dart';
import 'package:super_market/features/home/data/model/categories_model.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 64,
          crossAxisSpacing: 8,
          
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        
        itemCount: 8,
        itemBuilder: (context, index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey[300],
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(categories[index].image,),
                  
                ),
              ),
              SizedBox(height: 8,),
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  categories[index].name, 
                  style: TextStyle(fontSize: 16, ),)),
            ],
          );
        }),
    );
  }
}

