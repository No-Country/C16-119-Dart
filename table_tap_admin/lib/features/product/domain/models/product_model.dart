class ProductModel {
  final String id;
  final String name;
  final String? image;
  final String description;
  final String categoryId;
  final double price;
  final bool prepared;
  final bool status;
  final List<String>? ingredients;

  const ProductModel({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.prepared,
    required this.status,
    this.ingredients,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        description: json['description'],
        categoryId: json['categoryId'],
        price: json['price'].toDouble(),
        prepared: json['prepared'] as bool,
        status: json['status'] as bool,
        ingredients: json['ingredients'] != null
            ? List<String>.from(json['ingredients'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'description': description,
        'categoryId': categoryId,
        'price': price,
        'prepared': prepared,
        'status': status,
        'ingredients': ingredients,
      };
}
