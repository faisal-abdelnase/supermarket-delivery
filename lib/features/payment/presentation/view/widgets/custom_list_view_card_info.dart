import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/manager/cubit/my_cart_cubit.dart';
import 'package:super_market/features/payment/presentation/view/widgets/cart_item.dart';

class CustomListViewCardInfo extends StatelessWidget {
  const CustomListViewCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyCartCubit>();
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shrinkWrap: true,
          itemCount: cubit.productsCart.length,
          itemBuilder: (context, index) {
            
            final item = cubit.productsCart[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Dismissible(
                key: ValueKey(item.id),
                direction: DismissDirection.horizontal,
                onDismissed: (_) {
                  context
                      .read<MyCartCubit>()
                      .removeFromCart(item.id);
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: CartItem(cartInfoModel: item),
              ),
            );
          },
        );
    
  }
}
