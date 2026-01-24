import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/Functions/payment_method_dialog.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market/features/payment/presentation/manager/cubit/payment_cubit.dart';
import 'package:super_market/features/payment/presentation/view/widgets/custom_dotted_border_button.dart';
import 'package:super_market/features/payment/presentation/view/widgets/payment_method_card.dart';


class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  static const String paymentMethodId = "/paymentMethodId";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  spacing: MediaQuery.of(context).size.width * 0.1,
                  children: [
                    CustomArrowBackButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text("Payment Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
                  ],

                ),

                PaymentMethodCard(),

                SizedBox(
                  height: 24,
                ),

                CustomDottedBorderButton(
                  text: "Add New Card",
                  onPressed: (){}
                  ),

                

                

              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomElvatedButton(
          text: "Apply", onPressed: (){
            final cubit = context.read<PaymentCubit>();
            showAlertDialogPayment(context, cubit.paymentMethod.toString());
          }),
      ),

      
    );
  }

  
}

