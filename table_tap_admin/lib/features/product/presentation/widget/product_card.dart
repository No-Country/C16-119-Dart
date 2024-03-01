import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/shared/widgets/text_status.dart';

class ProductCard extends ConsumerWidget {
  final ProductModel product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Card(
      elevation: 2,
      shadowColor: colorPrincipal,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          context.push(
            RoutesConstants.productDetail,
            extra: {"id": product.id},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: product.image!.first,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                             const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                           const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${product.price}",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.category!,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(height: 8),
                        TextStatusCustomer(status: product.available),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
