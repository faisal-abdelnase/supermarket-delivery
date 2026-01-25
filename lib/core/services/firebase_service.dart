import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_market/features/payment/data/model/cart_info_model.dart';
import 'package:super_market/features/payment/data/model/payment_method_model.dart';
import 'package:super_market/features/profile/data/model/order_item.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create order with items in user's collection
  Future<void> createOrderInFirestore({
    required int orderId,
    required double amount,
    required String currency,
    required List<CartInfoModel> items,
    required PaymentMethod paymentMethod,
  }) async {
    try {
      // Get current user ID
      String? userId = _auth.currentUser?.uid;
      
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Prepare order data
      Map<String, dynamic> orderData = OrderItem(
        orderId: orderId.toString(),
        amount: amount,
        currency: currency,
        status: "ongoing",
        paymentMethod: paymentMethod.toString(),
        items: items,
        itemCount: items.length,
      ).toJson();

      // Store order in user's orders subcollection
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId.toString())
          .set(orderData);

      // Optional: Update user's total orders count
      await _firestore.collection('users').doc(userId).update({
        'totalOrders': FieldValue.increment(1),
        'lastOrderDate': FieldValue.serverTimestamp(),
      });

    } catch (e) {
      throw Exception('Failed to create order in Firestore: $e');
    }
  }

  // Get user orders
  Future<List<Map<String, dynamic>>> getUserOrders() async {
    try {
      String? userId = _auth.currentUser?.uid;
      
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Failed to get user orders: $e');
    }
  }

  // Get specific order
  Future<Map<String, dynamic>?> getOrderById(int orderId) async {
    try {
      String? userId = _auth.currentUser?.uid;
      
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId.toString())
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }
}