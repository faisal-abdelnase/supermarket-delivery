import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_app/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market_app/features/home/presentation/manager/filter_provider.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/range_slider_price.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/search_by_filter_header.dart';

import 'widgets/grid_view_button_filter.dart';

class SearchByFilter extends StatelessWidget {
  const SearchByFilter({super.key});

  static const String searchByFilterId = '/searchByFilter';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilterProvider(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
            
              children: [
                SearchByFilterHeader(),

                SizedBox(height: 16,),
                
                GridViewButtonFilter(),

                SizedBox(height: 16,),

                RangeSliderPrice(),

                SizedBox(height: 32,),

                CustomElvatedButton(text: "Apply Filter", onPressed: (){}),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

