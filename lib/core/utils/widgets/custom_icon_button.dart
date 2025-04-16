import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key, required this.onPressed, required this.icon, required this.backgroundColor, required this.iconSize, required this.minSize,
  });

  final void Function() onPressed;
  final Icon icon;
  final Color backgroundColor;
  final double iconSize;
  final Size minSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: minSize,
        iconSize: iconSize
      ),
      onPressed: onPressed, 
      icon: icon);
  }
}