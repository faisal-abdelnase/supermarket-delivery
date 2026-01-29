import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:super_market/core/services/firebase_service.dart';
import 'package:super_market/features/profile/data/model/order_item.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  FirebaseService firebaseService = FirebaseService();
  List<OrderItem> allOrders = [];

  List<OrderItem> onGoingOrder = [];
  List<OrderItem> completedOrder = [];
  List<OrderItem> cancelledOrder = [];


  Future<void> getOrders() async {

    emit(OrdersLoading());

    try{
      List<Map<String, dynamic>> orders = await firebaseService.getUserOrders();

      if(orders.isEmpty){
        emit(OrdersError(errMessage: "No orders found."));
        return;
      }

      // clear previous lists to avoid duplicates when fetching multiple times
      allOrders.clear();
      onGoingOrder.clear();
      completedOrder.clear();
      cancelledOrder.clear();

      allOrders = orders.map((order)=> OrderItem.fromJson(order)).toList();

      for(OrderItem order in allOrders){

        if(order.status == "ongoing"){
          onGoingOrder.add(order);
          log(order.status);

        } else if(order.status == "completed"){
          completedOrder.add(order);
          log(order.status);

        } else if(order.status == "cancelled"){
          cancelledOrder.add(order);
          log(order.status);
        }
      }

      emit(OrdersSuccess());
    } catch(e){
      emit(OrdersError(errMessage: "Failed to load orders."));
    }
  }
}
