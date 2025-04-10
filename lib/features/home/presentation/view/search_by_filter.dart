import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_app/constant.dart';
import 'package:super_market_app/features/home/presentation/manager/filter_provider.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/custom_elevated_button_filter.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/search_by_filter_header.dart';

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
                SizedBox(
                  height: 16,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3.2),
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return CustomElevatedButtonFilter(text: filter[index]);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
