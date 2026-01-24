import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {

  Future<void> createOrderInFirestore({
  required int orderId,
  required int amount,
  required String currency,
}) async {
  await FirebaseFirestore.instance
      .collection('orders')
      .doc(orderId.toString())
      .set({
    "orderId": orderId,
    "amount": amount,
    "currency": currency,
    "status": "pending",
    "createdAt": FieldValue.serverTimestamp(),
    "updatedAt": FieldValue.serverTimestamp(),
  });
}

}