import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/manager/cubit/my_cart_cubit.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';
import 'package:super_market/features/payment/presentation/view/checkout_view.dart';
import 'package:super_market/features/payment/presentation/view/widgets/coupon_code_text_field.dart';
import 'package:super_market/features/payment/presentation/view/widgets/custom_list_view_card_info.dart';
import 'package:super_market/features/payment/presentation/view/widgets/reset_cart.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  static const String myCartId = "/my cart id";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: BlocBuilder<MyCartCubit, MyCartState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      spacing: MediaQuery.of(context).size.width * 0.3,
                      children: [
                        CustomArrowBackButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              HomeView.homeId,
                            );
                          },
                        ),
                        Text(
                          "My Cart",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    CustomListViewCardInfo(),
                    CouponCodeTextField(),

                    ResetCart(),

                    CustomElvatedButton(
                      text: "Check Out",
                      onPressed: () {
                        Navigator.pushNamed(context, CheckoutView.checkoutId);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
