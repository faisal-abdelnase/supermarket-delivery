import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_app/features/home/presentation/manager/filter_provider.dart';

class CustomElevatedButtonFilter extends StatelessWidget {
  const CustomElevatedButtonFilter({
    super.key, required this.text, 
  });

  final String text;


  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        
        backgroundColor: filterProvider.isFilterSelected(text) ? Colors.blue : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        
        
      ),
      onPressed: (){
        filterProvider.toggleFilter(text);
      }, 
      child: Text(text, 
      style: 
      TextStyle(
        color: filterProvider.isFilterSelected(text) ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        
        ),),
      );
  }
}