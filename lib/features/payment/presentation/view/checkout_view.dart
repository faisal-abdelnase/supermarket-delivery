import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/manager/cubit/my_cart_cubit.dart';
import 'package:super_market/core/utils/Functions/show_snack_bar_message.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/payment/presentation/manager/cubit/payment_cubit.dart';
import 'package:super_market/features/payment/presentation/view/delivery_address_view.dart';
import 'package:super_market/core/utils/widgets/card_info.dart';
import 'package:super_market/features/payment/presentation/view/payment_method_view.dart';
import 'package:super_market/features/payment/presentation/view/widgets/custom_list_view_card_info.dart';
import 'package:super_market/features/payment/presentation/view/widgets/reset_cart.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  static const String checkoutId = "/checkout id";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: BlocBuilder<MyCartCubit, MyCartState>(
              builder: (context, state) {
                return Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: MediaQuery.of(context).size.width * 0.3,
                      children: [
                        CustomArrowBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "Delivery Address",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    CardInfo(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          DeliveryAddressView.addressViewID,
                        );
                      },
                      prefixIcon: Icons.location_on_outlined,
                      suffixIcon: Icons.arrow_forward_ios,
                      text:
                          '80 Banastre Road, Southport,SouthportSouthportSouthportSouthportSouthport',
                    ),

                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    CardInfo(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PaymentMethodView.paymentMethodId,
                        );
                      },
                      prefixIcon: Icons.payment,
                      suffixIcon: Icons.arrow_forward_ios,
                      text: '**** **** **** 1234',
                    ),

                    Text(
                      "Item List",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    CustomListViewCardInfo(),

                    ResetCart(),

                    BlocConsumer<PaymentCubit, PaymentState>(
                      listener: (context, state) {
                        if(state is PaymentError){
                          showSnackBarMessage(context, "invilde Pay", Colors.red);
                        }
                      },
                      builder: (context, state) {
                        final cubit = context.read<PaymentCubit>();
                        
                        return CustomElvatedButton(
                          isloading: state is PaymentLoading ? true : false,
                          text: "Place Order",
                          onPressed: () {
                            cubit.pay();
                          },
                        );
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
