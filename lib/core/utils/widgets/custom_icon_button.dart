import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key, required this.onPressed, required this.icon, required this.backgroundColor,
  });

  final void Function() onPressed;
  final Icon icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed, 
      icon: icon);
  }
}