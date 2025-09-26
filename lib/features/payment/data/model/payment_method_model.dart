class PaymentMethodModel {
  final String image;
  final String title;

  PaymentMethodModel({required this.image, required this.title});
}

List<PaymentMethodModel> paymentMethodList = [
  PaymentMethodModel(image: "assets/images/money.png", title: "Cash on Delivery"),
  PaymentMethodModel(image: "assets/images/master.png", title: "*** *** **** 1234"),
  PaymentMethodModel(image: "assets/images/visa.png", title: "*** *** **** 5678"),
  PaymentMethodModel(image: "assets/images/paypal.png", title: "*** *** **** 9012"),
  
];
