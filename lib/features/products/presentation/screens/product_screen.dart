import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';
import 'package:table_tap_customer/features/products/presentation/providers/product_provider.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final setProduct = ref.read(productSelectedProvider.notifier).setProduct;
    ThemeColors palette = ThemeColors.palette();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Editar Producto'),
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           // final photoPath = await CameraGalleryServiceImpl().takePhoto();
      //           // if (photoPath == null) return;

      //           // ref
      //           //     .read(productFormProvider(productState.product!).notifier)
      //           //     .updateProductImage(photoPath);
      //         },
      //         icon: const Icon(Icons.camera_alt_outlined))
      //   ],
      // ),
      body: const _ProductView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: palette.main,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          setProduct(Product(
              id: "asd",
              name: "chocolate",
              price: 12,
              time: 12,
              category: "pasd",
              photos: [
                "https://vecinavegetariana.com/wp-content/uploads/2022/04/Bandeja-Paisa-4.jpeg"
              ],
              description: "holi",
              ingredients: [
                "milk",
                "milk",
                "milk",
              ],
              available: true));
          // if (productState.product == null) return;

          // ref
          //     .read(productFormProvider(productState.product!).notifier)
          //     .onFormSubmit()
          //     .then((value) {
          //   if (!value) return;
          //   showSnackbar(context);
          // });
        },
        child: Icon(
          Icons.add,
          color: palette.light,
        ),
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {
  const _ProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Product product = ref.watch(productSelectedProvider);
    return Stack(
      children: [
        SizedBox(
          height: 300,
          width: 600,
          child: _ImageGallery(images: product.photos
              // [
              //   "https://i.ibb.co/m6PqGyG/Food-Picture.png",
              //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHcAO6UsKGnm6ljLkTyEDi8Dmzumf_JM22EM4OSPVaQUQJxEeEWTcowWS1RgohLri8WSY&usqp=CAU",
              //   "https://vecinavegetariana.com/wp-content/uploads/2022/04/Bandeja-Paisa-4.jpeg"
              // ]
              ),
        ),
        // SizedBox(height: 100),
        const _ProductDetail(),
      ],
    );
  }
}

class _ProductDetail extends ConsumerWidget {
  const _ProductDetail();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeColors palette = ThemeColors.palette();
    Product product = ref.watch(productSelectedProvider);
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.65,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey),
                    ),
                  ],
                ),
                ListView(
                  controller: scrollController,
                  children: [
                    ListTile(
                      title: Text(
                        product.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: palette.primaryTitle),
                      ),
                      subtitle: Text(
                        "Food - ${product.time} mins",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: palette.secondaryText),
                      ),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
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
                                  "Restaurant name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: palette.primaryTitle),
                                ),
                              ],
                            ),
                            Row(children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: palette.main,
                                child: IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.favorite,
                                        color: Color(0xffE3FFF8))),
                              ),
                              Text(
                                "60 likes",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: palette.primaryTitle),
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
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: palette.primaryTitle),
                        ),
                      ),
                      subtitle: Text(
                        product.description,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: palette.secondaryText),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Divider(),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(
                        "Ingredients",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: palette.primaryTitle),
                      ),
                    ),
                    for (final ingredient in product.ingredients)
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: palette.light,
                            child: Icon(Icons.check, color: palette.main)),
                        subtitle: Text(
                          ingredient,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: palette.primaryText),
                        ),
                      ),
                    const SizedBox(
                      height: 80,
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

class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
          child: Image.asset('assets/images/no_image.jpg', fit: BoxFit.cover));
    }

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 1),
      children: images.map((image) {
        late ImageProvider imageProvider;
        if (image.startsWith('http')) {
          imageProvider = NetworkImage(image);
        } else {
          // imageProvider = FileImage(File(image));
        }

        return ClipRRect(
            child: FadeInImage(
          fit: BoxFit.cover,
          image: imageProvider,
          placeholder: const AssetImage('assets/loaders/loader.gif'),
        ));
      }).toList(),
    );
  }
}
