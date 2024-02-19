class Product {
  String id;
  String name;
  double price;
  int time;
  String category;
  List<String> photos;
  String description;
  List<String> ingredients;
  bool available;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.time,
    required this.category,
    required this.photos,
    required this.description,
    required this.ingredients,
    required this.available,
  });
}
