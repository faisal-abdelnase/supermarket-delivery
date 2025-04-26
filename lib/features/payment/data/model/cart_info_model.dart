class CartInfoModel{
  final String image;
  final String poductName;
  final String description;
  final String productPrice;
  int productQuantity;

  CartInfoModel({
    required this.image, 
    required this.poductName, 
    required this.description, 
    required this.productPrice, 
    required this.productQuantity});


  static List<CartInfoModel> cartInfoList = [
    CartInfoModel(
      image: "assets/images/millk.jpg",
      poductName: "Milk",
      description: "1.5 L",
      productPrice: "\$110",
      productQuantity: 1,
    ),
    CartInfoModel(
      image: "assets/images/millk.jpg",
      poductName: "Milk",
      description: "1.5 L",
      productPrice: "\$110",
      productQuantity: 2,
    ),
    CartInfoModel(
      image: "assets/images/millk.jpg",
      poductName: "Milk",
      description: "1.5 L",
      productPrice: "\$110",
      productQuantity: 3,
    ),

    CartInfoModel(
      image: "assets/images/millk.jpg",
      poductName: "Milk",
      description: "1.5 L",
      productPrice: "\$110",
      productQuantity: 2,
    ),
  ];
}