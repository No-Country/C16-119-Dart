class ProductModel {
  final String? id;
  final String name;
  final List<String>? image;
  final String description;
  final String category;
  final double price;
  final bool prepared;
  final bool available;
  final int? time;
  final int? likes;
  final List<String>? ingredients;

  const ProductModel({
    this.id,
    required this.name,
    this.image,
    required this.description,
    required this.category,
    required this.price,
    required this.prepared,
    required this.available,
    this.ingredients,
    this.likes,
    this.time,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) =>
      ProductModel(
        id: id,
        name: json['name'],
        description: json['description'],
        category: json['category'],
        price: json['price'].toDouble(),
        prepared: json['prepared'] != null ? json['prepared'] as bool : false,
        available:
            json['available'] != null ? json['available'] as bool : false,
        time: json['time'] != null ? json['time'] as int : 0,
        likes: json['likes'] != null ? json['likes'] as int : 0,
        ingredients: json['ingredients'] != null
            ? List<String>.from(json['ingredients'])
            : null,
        image: json['image'] != null ? List<String>.from(json['image']) : null,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'description': description,
        'category': category,
        'price': price,
        'prepared': prepared,
        'available': available,
        'ingredients': ingredients,
        'time': time,
        'likes': likes,
      };

  ProductModel copyWith({
    String? id,
    String? name,
    List<String>? image,
    String? description,
    String? category,
    double? price,
    bool? prepared,
    bool? available,
    List<String>? ingredients,
    int? time,
    int? likes,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      prepared: prepared ?? this.prepared,
      available: available ?? this.available,
      ingredients: ingredients ?? this.ingredients,
      time: time ?? this.time,
      likes: likes ?? this.time,
    );
  }
}
