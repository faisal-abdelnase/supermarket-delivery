class CategoriesModel {
  final String name;
  final String image;

  CategoriesModel({required this.name, required this.image});
}


List<CategoriesModel> categories = [
  CategoriesModel(name: "meat and poultry", image: "assets/images/meet.png"),
  CategoriesModel(name: "Dairy and eggs", image: "assets/images/Dairy and eggs.jpg"),
  CategoriesModel(name: "fruits and vegetables", image: "assets/images/fruits and vegetables.jpg"),
  CategoriesModel(name: "Supermarket supplies", image: "assets/images/Supermarket supplies.png"),
  CategoriesModel(name: "washing powders", image: "assets/images/washing powders.jpg"),
  CategoriesModel(name: "drinks", image: "assets/images/drinks.jpg"),
  CategoriesModel(name: "frozen foods", image: "assets/images/frozen foods.jpg"),
  CategoriesModel(name: "Baby supplies", image: "assets/images/Baby supplies.jpg"),
];