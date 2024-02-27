import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: colorPrincipal,
      color: Colors.white,
      child: Padding(
        padding:const EdgeInsets.all(8.0),
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
                          "producto",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "500",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "activo",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "Categoria",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
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
                  context.push(RoutesConstants.productDetail);
                },
                icon: const Icon(
                  Icons.details_rounded,
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
