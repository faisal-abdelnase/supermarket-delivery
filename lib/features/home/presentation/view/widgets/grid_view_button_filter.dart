import 'package:flutter/material.dart';
import 'package:super_market_app/constant.dart';
import 'package:super_market_app/features/home/presentation/view/widgets/custom_elevated_button_filter.dart';

class GridViewButtonFilter extends StatelessWidget {
  const GridViewButtonFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
