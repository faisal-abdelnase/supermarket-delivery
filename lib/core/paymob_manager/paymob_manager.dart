

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:super_market/core/constant.dart';
import 'package:super_market/features/payment/data/model/payment_result.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymobManager {

  
  // Future<String> getPaymentKey(int amount, String currency) async {

  //   try{
  //     String authanticationToken = await _getAuthanticationToken();
    
  //   int orderId = await _getOrderId(
  //     authanticationToken: authanticationToken,
  //     amount: (amount * 100).toString(),
  //     currency: currency
  //   );

  //   String paymentKey = await _getPaymentKey(
  //     authanticationToken: authanticationToken,
  //     amount: (amount * 100).toString(),
  //     currency: currency,
  //     orderId: orderId.toString(),
  //   );

  //   return paymentKey;
  //   } catch(e){
  //     throw Exception('Failed to get payment key: $e');
  //   }
  // }

  // 1
  // get authantication token to access paymob api
  // user token

  Future<String> _getAuthanticationToken() async {

    final Response response = await Dio().post(
      'https://accept.paymob.com/api/auth/tokens',
      data: {
        "api_key": apiKeyPaymob,
        }
    );

    log(response.data['token']);

    return response.data['token'];
  }


  // 2
  // create order to get order id
  Future<int> _getOrderId({required String authanticationToken, required String amount, required String currency}) async {

    final Response response = await Dio().post(
      'https://accept.paymob.com/api/ecommerce/orders',
      data: {
        "auth_token": authanticationToken,
        "delivery_needed": "false",
        "amount_cents": amount,
        "currency": currency,
        "items": []
      },

      options: Options(headers: {
      "Content-Type": "application/json",
    }),
    );

    return response.data['id'];
  }

  // 3
  // get payment key to process payment

  Future<String> _getPaymentKey({
    required String authanticationToken,
    required String orderId,
    required String amount,
    required String currency,
    }) async {

    final Response response = await Dio().post(
      'https://accept.paymob.com/api/acceptance/payment_keys',
      data: {
        "expiration": 3600,
        "integration_id": integrationIdOnlineCardPaymob,
        "auth_token": authanticationToken,
        "amount_cents": amount,
        "currency": currency,
        "order_id": orderId,

        "billing_data": {

          "first_name": "Faisal",
          "last_name": "Abdelnasser",
          "email": "Faisal@gmail.com",
          "phone_number": "01234567890",

          
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "EG",
          "state": "NA",
          
          },
      }
    );

    return response.data['token'];
  }



  // Check transaction status
Future<PaymentResult> checkPaymentStatus(int orderId) async {
  try {
    // Get a FRESH token for each check
    String authenticationToken = await _getAuthanticationToken();
    
    final Response response = await Dio().get(
      'https://accept.paymob.com/api/ecommerce/orders/$orderId',
      queryParameters: {
        "token": authenticationToken, // Changed from "auth_token"
      }
    );

    final data = response.data;
    
    // Debug logging
    log('Order ID: $orderId');
    log('Payment Status: ${data['payment_status']}');
    log('Is Canceled: ${data['is_canceled']}');
    log('Paid Amount: ${data['paid_amount_cents']}');
    
    String? paymentStatus = data['payment_status']?.toString().toUpperCase();
    bool isCanceled = data['is_canceled'] == true || data['is_cancel'] == true;
    int paidAmount = data['paid_amount_cents'] ?? 0;
    
    if (paymentStatus == 'PAID' && paidAmount > 0) {
    
      return PaymentResult(
        status: PaymentStatus.success,
        transactionId: data['id'].toString(),
        message: 'Payment completed successfully',
      );
    } else if (isCanceled) {
      return PaymentResult(
        status: PaymentStatus.canceled,
        message: 'Payment was canceled',
      );
    } else if (paymentStatus == 'PENDING' || paymentStatus == 'TBC') {
      return PaymentResult(
        status: PaymentStatus.pending,
        message: 'Payment is being processed',
      );
    } else if (paymentStatus == 'FAILED' || paymentStatus == 'DECLINED') {
      return PaymentResult(
        status: PaymentStatus.failed,
        message: 'Payment failed or was declined',
      );
    } else if (paymentStatus == 'REFUNDED' || paymentStatus == 'VOIDED') {
      return PaymentResult(
        status: PaymentStatus.canceled,
        message: 'Payment was refunded',
      );
    } else {
      return PaymentResult(
        status: PaymentStatus.pending,
        message: 'Payment status: ${paymentStatus ?? "unknown"}',
      );
    }
  } catch (e) {
    log('Error checking payment status: $e');
    return PaymentResult(
      status: PaymentStatus.pending,
      message: 'Retrying payment status check...',
    );
  }
}



  // Alternative: Pay with order tracking
  Future<void> _pollPaymentStatus(
  int orderId,
  Function(PaymentResult) onPaymentResult,
  {int maxAttempts = 6, Duration initialInterval = const Duration(seconds: 2)}
) async {
  int attempts = 0;
  
  while (attempts < maxAttempts) {
    // Exponential backoff: 2s, 4s, 8s, 16s...
    await Future.delayed(initialInterval * (1 << attempts));
    
    try {
      PaymentResult result = await checkPaymentStatus(orderId);
      
      if (result.status == PaymentStatus.success || 
          result.status == PaymentStatus.failed ||
          result.status == PaymentStatus.canceled) {
        onPaymentResult(result);
        return;
      }
      
      attempts++;
    } catch (e) {
      log('Polling attempt ${attempts + 1} failed: $e');
      attempts++;
      
      if (attempts >= maxAttempts) {
        onPaymentResult(PaymentResult(
          status: PaymentStatus.failed,
          message: 'Payment verification failed after $maxAttempts attempts',
        ));
        return;
      }
    }
  }
  
  onPaymentResult(PaymentResult(
    status: PaymentStatus.pending,
    message: 'Payment still processing - please check order history',
  ));
}


// Alternative: Pay with order tracking
  Future<void> payWithTracking({
    required double amount,
    required String currency,
    required Function(PaymentResult) onPaymentResult,
  }) async {
    int orderId;
    
    try {
      String authenticationToken = await _getAuthanticationToken();
      log(authenticationToken);
      
      orderId = await _getOrderId(
        authanticationToken: authenticationToken,
        amount: (amount * 100).toString(),
        currency: currency
      );

      String paymentKey = await _getPaymentKey(
        authanticationToken: authenticationToken,
        amount: (amount * 100).toString(),
        currency: currency,
        orderId: orderId.toString(),
      );
      
      final url = Uri.parse(
        "https://accept.paymob.com/api/acceptance/iframes/996877?payment_token=$paymentKey"
      );
      
      final launched = await launchUrl(url);
      
      if (!launched) {
        onPaymentResult(PaymentResult(
          status: PaymentStatus.failed,
          message: 'Failed to launch payment page',
        ));
        return;
      }
      
    } catch (e) {
      onPaymentResult(PaymentResult(
        status: PaymentStatus.failed,
        message: 'Payment initialization failed: $e',
      ));
      return;
    }
  
  // Start polling in the background (don't await here to avoid blocking)
  // This runs independently and calls onPaymentResult when done
    _pollPaymentStatus(orderId, onPaymentResult);
  
}










  // Future<void> pay() async {
  //   getPaymentKey(10, "EGP").then((String paymentKey) async {
  //     await launchUrl(
  //       Uri.parse("https://accept.paymob.com/api/acceptance/iframes/996877?payment_token=$paymentKey"));
  //   });


    
  // }
}