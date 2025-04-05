import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/data/model/categories_model.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/header_home_page.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/sliver_to_box_adapter_text_type.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const homeId = "/homeView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          slivers: [

            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: HeaderHomePage(),
              ),
            ),

            SliverToBoxAdapterTextType(),
          

            SliverToBoxAdapter(
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
            )

            
          ],
        ),
      ),
    );
  }
}

