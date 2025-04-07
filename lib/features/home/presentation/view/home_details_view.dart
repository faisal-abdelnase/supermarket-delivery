import 'package:flutter/material.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/categories_grid_view.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/header_home_page.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/offers_list_view.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/recommended_list_view.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/sliver_to_box_adapter_text_type.dart';

class HomeDetailsView extends StatelessWidget {
  const HomeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
              child: SizedBox(height: 16,),
            ),

            SliverToBoxAdapterTextType(text: "Offers",),

            OffersListView(),


            
          ],
        ),
      );

  }
}