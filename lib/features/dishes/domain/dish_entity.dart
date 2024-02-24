class Dish {
  String idDish;
  String name;
  double price;
  int amount;
  List<String> photos;
  List<String>? ingredients;
  Dish(
      {required this.idDish,
      required this.name,
      required this.photos,
      required this.price,
      this.amount = 1,
      this.ingredients});

  Dish copyWith({
    String? idDish,
    String? name,
    List<String>? photos,
    double? price,
    int? amount,
    List<String>? ingredients,
  }) =>
      Dish(
        idDish: idDish ?? this.idDish,
        name: name ?? this.name,
        photos: photos ?? this.photos,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        ingredients: ingredients ?? this.ingredients,
      );
}
