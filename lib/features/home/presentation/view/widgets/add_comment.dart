import 'package:flutter/material.dart';

class AddComment extends StatelessWidget {
  const AddComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          maxLines: 4,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: "Write your comment here...",
            hintStyle: TextStyle(color: Colors.grey),
            
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
        
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
    
    
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.send, color: Colors.blue,)),
        )
      ],
    );
  }
}

