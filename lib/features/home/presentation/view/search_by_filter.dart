import 'package:flutter/material.dart';
import 'package:super_market_app/features/Auth/presentation/view/widgets/custom_arrow_back_button.dart';

class SearchByFilter extends StatelessWidget {
  const SearchByFilter({super.key});

  static const String searchByFilterId = '/searchByFilter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
        children: [
          Row(
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
          ),

          
        ],
            ),
      ),
    );
  }
}