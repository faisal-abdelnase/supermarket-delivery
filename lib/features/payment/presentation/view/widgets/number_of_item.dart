import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:super_market/core/manager/cubit/my_cart_cubit.dart';
import 'package:super_market/core/utils/widgets/custom_icon_button.dart';
import 'package:super_market/features/payment/data/model/cart_info_model.dart';

class NumberOfItem extends StatelessWidget {
  const NumberOfItem({super.key, required this.cartInfoModel});

  final CartInfoModel cartInfoModel;

  @override
  Widget build(BuildContext context) {
    

    return BlocBuilder<MyCartCubit, MyCartState>(
      builder: (context, state) {
        final cubit = context.read<MyCartCubit>();
        return Row(
          children: [
            CustomIconButton(
              iconSize: 16,
              minSize: Size(20, 20),
              backgroundColor: Colors.grey[300]!,
              icon: Icon(Icons.remove),
              onPressed: () {
                if (cartInfoModel.productQuantity > 1) {
                  cubit.updateQuantity(
                    productId: cartInfoModel.id,
                    newQuantity: cartInfoModel.productQuantity - 1,
                  );
                }
              },
            ),

            Text(
              cartInfoModel.productQuantity.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            CustomIconButton(
              iconSize: 16,
              minSize: Size(20, 20),
              backgroundColor: Colors.blue,
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                cubit.updateQuantity(
                  productId: cartInfoModel.id,
                  newQuantity: cartInfoModel.productQuantity + 1,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
