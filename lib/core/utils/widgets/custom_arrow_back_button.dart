import 'package:flutter/material.dart';

class CustomArrowBackButton extends StatelessWidget {
  const CustomArrowBackButton({
    super.key, required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 239, 238, 238)
      ),
      onPressed: onPressed,
      icon: Icon(Icons.arrow_back)
      );
  }
}