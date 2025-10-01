import 'package:flutter/material.dart';

showSnackBarMessage(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: color,
            ),
          );
}