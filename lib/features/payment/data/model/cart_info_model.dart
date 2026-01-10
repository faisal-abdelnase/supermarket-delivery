class CartInfoModel{
  final String id;
  final String image;
  final String poductName;
  final String description;
  final String productPrice;
  int productQuantity;

  CartInfoModel(
    {
    required this.id, 
    required this.image, 
    required this.poductName, 
    required this.description, 
    required this.productPrice, 
    required this.productQuantity});


  CartInfoModel copyWith({
  int? productQuantity,
}) {
  return CartInfoModel(
    id: id,
    image: image,
    poductName: poductName,
    description: description,
    productPrice: productPrice,
    productQuantity: productQuantity ?? this.productQuantity,
  );
}


  static List<CartInfoModel> cartInfoList = [
    CartInfoModel(
      id: "1",
      image: "assets/images/millk.jpg",
      poductName: "Milk",
      description: "1.5 L",
      productPrice: "\$110",
      productQuantity: 1,
    ),
    CartInfoModel(
      id: "2",
      image: "assets/images/millk.jpg",
      poductName: "Milk",
      description: "1.5 L",
      productPrice: "\$110",
      productQuantity: 2,
    ),
    CartInfoModel(
      id: "3",
      image: "assets/images/millk.jpg",
      poductName: "Milk",
      description: "1.5 L",
      productPrice: "\$110",
      productQuantity: 3,
    ),

    CartInfoModel(
      id: "4",
      image: "assets/images/millk.jpg",
      poductName: "Milk",
      description: "1.5 L",
      productPrice: "\$110",
      productQuantity: 2,
    ),
  ];
}