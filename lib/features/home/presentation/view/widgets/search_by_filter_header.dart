import 'package:flutter/material.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_arrow_back_button.dart';

class SearchByFilterHeader extends StatelessWidget {
  const SearchByFilterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomArrowBackButton(),
        Text(
          'Search By Filter',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
    
        TextButton(
          onPressed: (){}, 
          child: Text("Reset", 
          style: TextStyle(color: Colors.blue),
          ),
          ),
      ],
    );
  }
}