import 'package:flutter/material.dart';
import 'package:super_market/features/payment/presentation/view/widgets/reset_item.dart';

class ResetCart extends StatelessWidget {
  const ResetCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
    
      child: Column(
        spacing: 8,
        children: [
          ResetItem(title: "Total Item", value: "03",),
          ResetItem(title: "subTotal", value: "\$84.50",),
          ResetItem(title: "VAT", value: "\$00.00"),
          ResetItem(title: "Shipping Fee", value: "\$00.50",),
          Divider(),
          ResetItem(title: "Total Payable", value: "\$85.00", color: Colors.blue,),
          
        ],
      ),
    );
  }
}


