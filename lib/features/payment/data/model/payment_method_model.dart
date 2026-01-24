
enum  PaymentMethod  {
  cach,
  card,
  vodafoneCash,
  etisalatCash,
  orangeCash,
}

class PaymentMethodModel {
  final String image;
  final String title;
  final PaymentMethod paymentMethodeType;

  PaymentMethodModel({required this.image, required this.title, required this.paymentMethodeType});
}

List<PaymentMethodModel> paymentMethodList = [
  PaymentMethodModel(image: "assets/images/money.png", title: "Cash on Delivery", paymentMethodeType: PaymentMethod.cach),
  PaymentMethodModel(image: "assets/images/master.png", title: "*** *** **** 1234", paymentMethodeType: PaymentMethod.card),
  PaymentMethodModel(image: "assets/images/visa.png", title: "*** *** **** 5678", paymentMethodeType: PaymentMethod.card),
  PaymentMethodModel(image: "assets/images/paypal.png", title: "*** *** **** 9012", paymentMethodeType: PaymentMethod.card),
  
];
