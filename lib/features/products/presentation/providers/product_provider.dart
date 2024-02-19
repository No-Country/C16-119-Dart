import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';

// part 'product_provider.g.dart';

// @riverpod
// Product productSelected(ProductSelectedRef ref) {
//   return Product(
//       id: "1",
//       name: "Cacao Maca Walnut Milk",
//       price: 2000,
//       time: 15,
//       category: "desayuno",
//       photos: ["https://i.ibb.co/m6PqGyG/Food-Picture.png"],
//       description:
//           "Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your",
//       ingredients: [
//         "1 eggs",
//         "1 eggs",
//         "1 eggs",
//         "1 eggs",
//         "1 eggs",
//       ],
//       available: true);
//   void setProductSelected() {
//     state;
//   }
// }

part 'product_provider.g.dart';

@riverpod
class ProductSelected extends _$ProductSelected {
  @override
  Product build() => Product(
      id: "1",
      name: "Cacao Maca Walnut Milk",
      price: 2000,
      time: 15,
      category: "desayuno",
      photos: ["https://i.ibb.co/m6PqGyG/Food-Picture.png", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHcAO6UsKGnm6ljLkTyEDi8Dmzumf_JM22EM4OSPVaQUQJxEeEWTcowWS1RgohLri8WSY&usqp=CAU"],
      description:
          "Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your",
      ingredients: [
        "4 Eggs",
        "1/2 Butter",
        "1/2 Butter",
        "Fruits",
        "Crepes",
        "Sugar",
        "Salad",
      ],
      available: true);

  void setProduct(Product newProduct) => state = newProduct;
}
