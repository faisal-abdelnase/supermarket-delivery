import 'package:flutter/material.dart';

class CustomElevatedButtonFilter extends StatefulWidget {
  const CustomElevatedButtonFilter({
    super.key, required this.text,
  });

  final String text;

  @override
  State<CustomElevatedButtonFilter> createState() => _CustomElevatedButtonFilterState();
}

class _CustomElevatedButtonFilterState extends State<CustomElevatedButtonFilter> {

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        
        
      ),
      onPressed: (){
        isSelected = !isSelected;
        setState(() {});
      }, 
      child: Text(widget.text, 
      style: 
      TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        
        ),),
      );
  }
}