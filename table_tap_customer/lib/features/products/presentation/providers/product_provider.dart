import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/dishes/domain/dish_entity.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';

part 'product_provider.g.dart';

@riverpod
class ProductSelected extends _$ProductSelected {
  @override
  Product build() => Product(
      idProduct: "1",
      time: 15,
      likes: 273,
      category: "desayuno",
      description:
          "Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your",
      available: true,
      dish: Dish(
        idDish: "1",
        name: "Cacao Maca Walnut Milk",
        photos: [
          "https://i.ibb.co/m6PqGyG/Food-Picture.png",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHcAO6UsKGnm6ljLkTyEDi8Dmzumf_JM22EM4OSPVaQUQJxEeEWTcowWS1RgohLri8WSY&usqp=CAU"
        ],
        price: 2000,
        ingredients: [
          "4 Eggs",
          "1/2 Butter",
          "Milk",
          "Fruits",
          "Flour",
          "Sugar",
          "Salad",
          "Walnut",
          "Cacao",
        ],
      ));

  void setProduct(Product newProduct) => state = newProduct;
  void setProductLikes(int likes) => state.likes = likes;
}
