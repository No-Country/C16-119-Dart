
class DishModel {
  final int amount;
  final double price;
  final String name;
  final List<String> ingredients;
  final List<String> photos;

  DishModel({
    required this.amount,
    required this.price,
    required this.name,
    required this.ingredients,
    required this.photos,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      amount: json['amount'] as int,
      price: json['price'] as double,
      name: json['name'] as String,
      ingredients: List<String>.from(json['ingredients'] as List<dynamic>),
      photos: List<String>.from(json['photos'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'price': price,
      'name': name,
      'ingredients': ingredients,
      'photos': photos,
    };
  }

  DishModel copyWith({
    int? amount,
    double? price,
    String? name,
    List<String>? ingredients,
    List<String>? photos,
  }) {
    return DishModel(
      amount: amount ?? this.amount,
      price: price ?? this.price,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      photos: photos ?? this.photos,
    );
  }
}
