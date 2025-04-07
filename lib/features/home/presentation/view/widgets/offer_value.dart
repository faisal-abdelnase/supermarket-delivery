import 'package:flutter/material.dart';

class OfferValue extends StatelessWidget {
  const OfferValue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text("50%", style: TextStyle(color: Colors.white, fontSize: 12),),
      ),
    );
  }
}