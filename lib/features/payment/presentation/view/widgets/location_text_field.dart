import 'package:flutter/material.dart';

class LocationTextField extends StatelessWidget {
  const LocationTextField({super.key, required this.hintText, required this.icon, required this.controller, required this.readOnly, this.onTap});

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
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
        
    
        prefixIcon: Icon(icon, color: Colors.grey,),
      ),
    );
  }
}