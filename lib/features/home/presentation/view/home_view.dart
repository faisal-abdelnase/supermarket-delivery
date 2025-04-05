import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/categories_grid_view.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/header_home_page.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/recommended_list_view.dart';
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

            SliverToBoxAdapterTextType(text: "Categories",),

            CategoriesGridView(),

            SliverToBoxAdapter(
              child: SizedBox(height: 64,),
            ),

            SliverToBoxAdapterTextType(text: "Recommended",),

            RecommendedListView(),

            SliverToBoxAdapter(
              child: SizedBox(height: 64,),
            ),

            SliverToBoxAdapterTextType(text: "Recommended",),


            
          ],
        ),
      ),
    );
  }
}



