class AboutDataModel{

  final String image;
  final String title;
  final String subTitle;

  AboutDataModel({required this.image, required this.title, required this.subTitle});


  static List<AboutDataModel> aboutData = [
  AboutDataModel(image: "assets/images/fast_delivery.png", title: "Fast & Get Best Product", subTitle: "We have the best products in all branches\n\t\t\t\t\t\t\t\t\t\t\t\tand our service is 24 hours"),
  AboutDataModel(image: "assets/images/map.jpeg", title: "Find superMarket Near You", subTitle: "We have the best products in all branches\n\t\t\t\t\t\t\t\t\t\t\t\t and our service is 24 hours"),
  AboutDataModel(image: "assets/images/payment.jpeg", title: "Easy Payment System", subTitle: "We have the best products in all branches\n\t\t\t\t\t\t\t\t\t\t\t\t and our service is 24 hours")
];

}