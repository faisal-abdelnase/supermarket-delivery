import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market/core/utils/widgets/card_info.dart';
import 'package:super_market/features/profile/presentation/manager/orders_cubit/orders_cubit.dart';
import 'package:super_market/features/profile/presentation/view/my_order_view.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        CardInfo(
          prefixIcon: Icons.person_outline_rounded, 
          suffixIcon: Icons.arrow_forward_ios, 
          text: "My Account", 
          onPressed: (){}
          ),
        
        
          CardInfo(
          prefixIcon: Icons.list_alt_rounded, 
          suffixIcon: Icons.arrow_forward_ios, 
          text: "My Order", 
          onPressed: () async{
            Navigator.pushNamed(context, MyOrderView.myOrderId);
            await context.read<OrdersCubit>().getOrders();
          }
          ),
        
        
          CardInfo(
          prefixIcon: Icons.attach_money, 
          suffixIcon: Icons.arrow_forward_ios, 
          text: "My Vouchers", 
          onPressed: (){}
          ),
        
        
          CardInfo(
          prefixIcon: Icons.payment_outlined, 
          suffixIcon: Icons.arrow_forward_ios, 
          text: "Payment Method", 
          onPressed: (){}
          ),
        
        
          CardInfo(
          prefixIcon: Icons.location_on_outlined, 
          suffixIcon: Icons.arrow_forward_ios, 
          text: "Address", 
          onPressed: (){}
          ),
      ],
    );
  }
}

