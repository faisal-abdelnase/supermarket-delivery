import 'package:flutter/material.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search For Location",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        fillColor: Colors.grey[200],
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
    
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        
    
        prefixIcon: Icon(Icons.search, color: Colors.grey,),
      ),
    );
  }
}