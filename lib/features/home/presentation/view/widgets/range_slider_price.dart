import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market/features/home/presentation/manager/filter_provider.dart';

class RangeSliderPrice extends StatelessWidget {
  const RangeSliderPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price Range", style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        
        RangeSlider(
          values: filterProvider.currentRangeValues,
          activeColor: Colors.blue,
          
          min: 10,
          max: 400,
          divisions: 40,
          labels: RangeLabels("${filterProvider.currentRangeValues.start.round()}\$", "${filterProvider.currentRangeValues.end.round()}\$"),
          onChanged: (value){
          
              filterProvider.setRangeValues(value);
        
          }
          ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${filterProvider.currentRangeValues.start.round()}\$", style: TextStyle(fontWeight: FontWeight.bold),),
              Text("${filterProvider.currentRangeValues.end.round()}\$", style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }
}

