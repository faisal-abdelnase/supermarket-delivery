import 'package:flutter/material.dart';
import 'package:super_market_app/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market_app/core/utils/widgets/custom_elvated_button.dart';
import 'package:super_market_app/features/home/presentation/view/home_view.dart';
import 'package:super_market_app/features/payment/presentation/view/checkout_view.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/coupon_code_text_field.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/custom_list_view_card_info.dart';
import 'package:super_market_app/features/payment/presentation/view/widgets/reset_cart.dart';


class MyCart extends StatefulWidget {
  const MyCart({super.key});

  static const String myCartId = "/my cart id";

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
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
                  spacing: MediaQuery.of(context).size.width * 0.3,
                  children: [
                    CustomArrowBackButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, HomeView.homeId);
                      },
                    ),
                    Text("My Cart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  ],
            
                ),
            
                // ListView.builder(
                //   physics: NeverScrollableScrollPhysics(),
                //   padding: EdgeInsets.symmetric(vertical: 16),
                //   shrinkWrap: true,
                //   itemCount: CartInfoModel.cartInfoList.length,
                //   itemBuilder: (context, index) {
                //   return Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 8),
                //     child: CartItem(cartInfoModel: CartInfoModel.cartInfoList[index],),
                //   );
                // },),


                CustomListViewCardInfo(),  
                CouponCodeTextField(),

                ResetCart(),

                CustomElvatedButton(
                  text: "Check Out", 
                  onPressed: (){
                    Navigator.pushNamed(context, CheckoutView.checkoutId);
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

