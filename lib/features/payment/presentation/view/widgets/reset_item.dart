import 'package:flutter/material.dart';

class ResetItem extends StatelessWidget {
  const ResetItem({
    super.key, required this.title, required this.value, this.color = Colors.black,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, 
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey),
          ),
        Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w500),),
      ],
    );
  }
}