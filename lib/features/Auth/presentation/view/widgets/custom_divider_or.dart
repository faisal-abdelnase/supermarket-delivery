import 'package:flutter/material.dart';

class CustomDividerOR extends StatelessWidget {
  const CustomDividerOR({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            indent: 4,
            endIndent: 4,
            
          ),
        ),
    
        Text("Or"),
    
        Expanded(
          child: Divider(
            thickness: 1,
            indent: 4,
            endIndent: 4,
            
          ),
        ),
      ],
    );
  }
}
