import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          ),
      fillColor: Colors.grey[200],
      filled: true,
      prefixIcon: Icon(Icons.search, color: Colors.grey,),
      suffixIconColor: Colors.blue,
            
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent)
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2,
        )
    )
            ),
    );
  }
}