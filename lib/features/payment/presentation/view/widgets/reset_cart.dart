import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/manager/cubit/my_cart_cubit.dart';
import 'package:super_market/features/payment/presentation/view/widgets/reset_item.dart';

class ResetCart extends StatelessWidget {
  const ResetCart({super.key});

  @override
  Widget build(BuildContext context) {
    
        final cubit = context.read<MyCartCubit>();
        
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
                ResetItem(title: "Total Item", value: cubit.resetCart.totalItem.toString()),
                ResetItem(title: "subTotal", value: "\$${cubit.resetCart.subTotal}"),
                ResetItem(title: "VAT", value: "\$${cubit.resetCart.vat}"),
                ResetItem(title: "Shipping Fee", value: "\$${cubit.resetCart.shippingFee}"),
                Divider(),
                ResetItem(
                  title: "Total Payable",
                  value: "\$${cubit.resetCart.totalPayable}",
                  color: Colors.blue,
                ),
              ],
            ),
          );
        
      
    
  }
}
