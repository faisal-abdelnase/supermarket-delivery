import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_market/features/payment/data/model/cart_info_model.dart';

class OrderItem {
  final String orderId;
  final double amount;
  final String currency;
  final String status;
  final String paymentMethod;
  final List<CartInfoModel> items;
  final int itemCount;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  OrderItem({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    required this.items,
    required this.itemCount,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'paymentMethod': paymentMethod,
      'items': items.map((e) => e.toJson()).toList(),
      'itemCount': itemCount,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }


  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderId: json['orderId'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      items: (json['items'] as List)
          .map((e) => CartInfoModel.fromJson(e))
          .toList(),
      itemCount: json['itemCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
