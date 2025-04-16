import 'package:flutter/material.dart';

class CouponCodeTextField extends StatelessWidget {
  const CouponCodeTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Enter your coupon code",
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
        
        suffixIcon: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: (){}, 
          icon: Icon(Icons.arrow_forward_outlined, color: Colors.white,),
          ),
    
        suffixIconConstraints: BoxConstraints(
          maxHeight: 50,
          maxWidth: 50,
        ),
    
        prefixIcon: Icon(Icons.search, color: Colors.grey,),
      ),
    );
  }
}