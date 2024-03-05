import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/product/presentation/widget/image_gallery.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final String productIds;

  const ProductDetailsScreen({super.key, required this.productIds});

  @override
  Widget build(BuildContext context, ref) {
    final productAsync = ref.watch(productsProvider);
    final product =
        ref.read(productsProvider.notifier).getProductById(productIds);

    return Scaffold(
      appBar: AppBar(title: const Text("Detalles")),
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (_) {
          if (product != null) {
            return _ProductView(product: product);
          } else {
            return const Center(child: Text('Producto no encontrado'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
            RoutesConstants.productEdit,
            extra: {"id": productIds},
          );
        },
        backgroundColor: colorSecondary,
        child: const Icon(
          Icons.edit,
          color: colorPrincipal,
          size: 30,
        ),
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {
  final ProductModel product;

  const _ProductView({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        SizedBox(
          height: 350,
          width: 600,
          child: ImageGallery(imageUrl: product.image!.first),
        ),
        _ProductDetail(product: product),
      ],
    );
  }
}

class _ProductDetail extends ConsumerWidget {
  final ProductModel product;

  const _ProductDetail({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                ListView(
                  controller: scrollController,
                  children: [
                    ListTile(
                      title: Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(
                        "Food - mins",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      dense: true,
                      title: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.centerLeft,
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                    "https://i.pinimg.com/originals/4e/24/f5/4e24f523182e09376bfe8424d556610a.png"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  product.category,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundColor: colorSecondary,
                                child: Icon(
                                  Icons.money_off_sharp,
                                  color: colorPrincipal,
                                ),
                              ),
                              Text(
                                "${product.price}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Divider(),
                    ),
                    ListTile(
                      title: const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        product.description,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Divider(),
                    ),
                    if (product.ingredients!.length > 0)
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(
                          "Ingredientes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    for (final ingredient in product.ingredients!)
                      ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: 0,
                          vertical: -4,
                        ),
                        leading: const CircleAvatar(
                          backgroundColor: colorSecondary,
                          radius: 15,
                          child: Icon(Icons.check, color: colorPrincipal),
                        ),
                        subtitle: Text(
                          ingredient,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: colorTerciario,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
