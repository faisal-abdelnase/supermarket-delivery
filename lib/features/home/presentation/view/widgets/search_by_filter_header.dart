import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/features/home/presentation/manager/filter_provider.dart';

class SearchByFilterHeader extends StatelessWidget {
  const SearchByFilterHeader({
    super.key, 
  });

  

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomArrowBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Text(
          'Search By Filter',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
    
        TextButton(
          onPressed: (){

            filterProvider.clearFilters();
            
          }, 
          child: Text("Reset", 
          style: TextStyle(color: Colors.blue),
          ),
          ),
      ],
    );
  }
}