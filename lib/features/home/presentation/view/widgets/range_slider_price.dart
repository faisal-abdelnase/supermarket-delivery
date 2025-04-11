import 'package:flutter/material.dart';

class RangeSliderPrice extends StatefulWidget {
  const RangeSliderPrice({
    super.key,
  });

  @override
  State<RangeSliderPrice> createState() => _RangeSliderPriceState();
}

class _RangeSliderPriceState extends State<RangeSliderPrice> {

  RangeValues _currentRangeValues =  RangeValues(10, 400);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price Range", style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        
        RangeSlider(
          values: _currentRangeValues,
          activeColor: Colors.blue,
          
          min: 10,
          max: 400,
          divisions: 40,
          labels: RangeLabels("${_currentRangeValues.start.round()}\$", "${_currentRangeValues.end.round()}\$"),
          onChanged: (value){
            setState(() {
              _currentRangeValues = value;
            });
          }
          ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${_currentRangeValues.start.round()}\$", style: TextStyle(fontWeight: FontWeight.bold),),
              Text("${_currentRangeValues.end.round()}\$", style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }
}

