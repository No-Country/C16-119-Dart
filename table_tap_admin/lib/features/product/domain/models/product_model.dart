class ProductModel {
  final String? id;
  final String name;
  final String? image;
  final String description;
  final String categoryId;
  final double price;
  final bool prepared;
  final bool available;
  final List<String>? ingredients;

  const ProductModel({
    this.id,
    required this.name,
    this.image,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.prepared,
    required this.available,
    this.ingredients,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) =>
      ProductModel(
        id: id,
        name: json['name'],
        image: json['image'],
        description: json['description'],
        categoryId: json['categoryId'],
        price: json['price'].toDouble(),
        prepared: json['prepared'] as bool,
        available: json['available'] as bool,
        ingredients: json['ingredients'] != null
            ? List<String>.from(json['ingredients'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'description': description,
        'categoryId': categoryId,
        'price': price,
        'prepared': prepared,
        'available': available,
        'ingredients': ingredients,
      };

  ProductModel copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    String? categoryId,
    double? price,
    bool? prepared,
    bool? available,
    List<String>? ingredients,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      prepared: prepared ?? this.prepared,
      available: available ?? this.available,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
