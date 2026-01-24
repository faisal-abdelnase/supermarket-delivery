import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market/features/payment/data/model/payment_method_model.dart';
import 'package:super_market/features/payment/presentation/manager/cubit/payment_cubit.dart';

class PaymentMethodCard extends StatefulWidget {
  const PaymentMethodCard({
    super.key,
  });

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {

  int selectindex = 0;
  @override
  Widget build(BuildContext context) {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: paymentMethodList.length,
    itemBuilder: (context, index) {
      final cubit = context.read<PaymentCubit>();
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(paymentMethodList[index].image, width: 25, height: 25),
            SizedBox(width: 8),
            Text(paymentMethodList[index].title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Spacer(),
            Radio<int>(
              
              activeColor: Colors.blue,
              value: index,
              groupValue: selectindex,
              onChanged: (value) {
                setState(() {
                  selectindex = value!;
                  cubit.paymentMethod = paymentMethodList[index].paymentMethodeType;

                  log(cubit.paymentMethod.toString());
                });
              },
            ),
          ],
        ),
      );
    },
  );
}
}