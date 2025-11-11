class ProductsModel {
  final String id;
  final String categories;
  final String name;
  final double price;
  final String image;
  final String description;
  final double rating;
  final bool isOffers;
  final double offersValue;


  ProductsModel({
    required this.id,
    required this.categories,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.rating,
    required this.isOffers,
    required this.offersValue,
  });


  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['_id'].toString(),
      categories: json['categories'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] as double? ?? 0.0),
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] is int) ? (json['rating'] as int).toDouble() : (json['rating'] as double? ?? 0.0),
      isOffers: json['isOffers'] ?? false,
      offersValue: (json['offersValue'] is int) ? (json['offersValue'] as int).toDouble() : (json['offersValue'] as double? ?? 0.0),
    );
  }



  factory ProductsModel.empty() {
    return ProductsModel(
      id: '',
      categories: '',
      name: '',
      price: 0.0,
      image: '',
      description: '',
      rating: 0.0,
      isOffers: false,
      offersValue: 0.0,
    );
  }

}