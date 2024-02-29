import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/shared/widgets/text_status.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: colorPrincipal,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/splash.png',
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "${product.price}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          product.categoryId,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextStatusCustomer(status: product.available),
                      ],
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () {
                  context.push(
                    RoutesConstants.productDetail,
                    extra: {"id": product.id},
                  );
                },
                icon: const Icon(
                  Icons.search_sharp,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
