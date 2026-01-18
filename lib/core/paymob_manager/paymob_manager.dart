import 'package:dio/dio.dart';
import 'package:super_market/core/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymobManager {

  
  Future<String> getPaymentKey(int amount, String currency) async {

    try{
      String authanticationToken = await _getAuthanticationToken();
    
    int orderId = await _getOrderId(
      authanticationToken: authanticationToken,
      amount: (amount * 100).toString(),
      currency: currency
    );

    String paymentKey = await _getPaymentKey(
      authanticationToken: authanticationToken,
      amount: (amount * 100).toString(),
      currency: currency,
      orderId: orderId.toString(),
    );

    return paymentKey;
    } catch(e){
      throw Exception('Failed to get payment key: $e');
    }
  }

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
        "integration_id": integrationIdPaymob,
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




  Future<void> pay() async {
    getPaymentKey(10, "EGP").then((String paymentKey) async {
      await launchUrl(
        Uri.parse("https://accept.paymob.com/api/acceptance/iframes/996877?payment_token=$paymentKey"));
    });


    
  }
}