import 'package:flutter/material.dart';

class ChekoutInfo extends StatelessWidget {
  const ChekoutInfo({
    super.key, required this.prefixIcon, required this.suffixIcon, required this.text,
  });

  final IconData prefixIcon;
  final IconData suffixIcon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 16,
        children: [
          Icon(prefixIcon, color: Colors.black87),
    
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
    
    
          IconButton(
            onPressed: (){}, 
            icon: Icon(suffixIcon, size: 16, color: Colors.black38),)
        ],
      ),
    );
  }
}