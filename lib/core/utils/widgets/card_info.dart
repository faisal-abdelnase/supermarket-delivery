import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key, required this.prefixIcon, required this.suffixIcon, required this.text, required this.onPressed,
  });

  final IconData prefixIcon;
  final IconData suffixIcon;
  final String text;
  final void Function() onPressed;

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
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
    
    
          IconButton(
            onPressed: onPressed, 
            icon: Icon(suffixIcon, size: 16),)
        ],
      ),
    );
  }
}