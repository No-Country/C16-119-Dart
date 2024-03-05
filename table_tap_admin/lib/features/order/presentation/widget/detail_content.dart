import 'package:flutter/material.dart';
import 'package:table_tap_admin/features/order/domain/models/dishes_model.dart';
import 'package:table_tap_admin/features/shared/widgets/image_custom.dart';

class DetailContent extends StatelessWidget {
  final List<DishModel> dishes;

  const DetailContent({Key? key, required this.dishes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("LISta de orden ${dishes.first.ingredients.first}");
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Platos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      dish.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cantidad: ${dish.amount}"),
                        Text("Precio Unitario: ${dish.price}"),
                        if (dish.photos.isNotEmpty)
                          ImageCustom(
                            initialImageUrl: dish.photos.first,
                          ),
                        const SizedBox(height: 5),
                        const Text(
                          "Ingredientes:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dish.ingredients.map((ingredient) {
                            return Text("- $ingredient");
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
