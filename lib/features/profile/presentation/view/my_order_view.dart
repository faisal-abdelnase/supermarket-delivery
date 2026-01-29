import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/features/profile/presentation/manager/orders_cubit/orders_cubit.dart';
import 'package:super_market/features/profile/presentation/view/my_profile_view.dart';
import 'package:super_market/features/profile/presentation/view/widgets/my_order_list_view.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  static const String myOrderId = "/myOrderId";

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  spacing: MediaQuery.of(context).size.width * 0.3,
                  children: [
                    CustomArrowBackButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          MyProfileView.myProfileId,
                        );
                      },
                    ),
                    Text(
                      "My Order",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                TabBar(
                  indicatorColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.blue,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Ongoing"),
                    Tab(text: "Completed"),
                    Tab(text: "Cancelled"),
                  ],
                ),

                BlocConsumer<OrdersCubit, OrdersState>(
                  listener: (context, state) {
                    if(state is OrdersError){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errMessage),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {

                    final orderCuit = context.read<OrdersCubit>();

                    if(state is OrdersLoading){
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Expanded(
                      child: TabBarView(
                        children: [
                          MyOrderListView(
                            textButton: "Cancel",
                            textButton2: "Track Order",
                            hiddenButton: true,
                            orders: orderCuit.onGoingOrder,
                          ), // ongoing
                          MyOrderListView(
                            textButton: "Rating",
                            textButton2: "Re-Order",
                            hiddenButton: true,
                            orders: orderCuit.completedOrder,
                          ), // completed
                          MyOrderListView(
                            textButton: "Reorder",
                            textButton2: "Re-Order",
                            hiddenButton: false,
                            orders: orderCuit.cancelledOrder,
                          ), // cancelled
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
