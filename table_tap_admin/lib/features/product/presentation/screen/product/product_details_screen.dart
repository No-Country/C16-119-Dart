import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(),
      body: const _ProductView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
  const _ProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Stack(
      children: [
        SizedBox(
          height: 350,
          width: 600,
          child: _ImageGallery(images: []),
        ),
        _ProductDetail(),
      ],
    );
  }
}

class _ProductDetail extends ConsumerWidget {
  const _ProductDetail();
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
                    const ListTile(
                      title: Text(
                        "Pizza",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
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
                                const Text(
                                  "Comida rapida",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: colorSecondary,
                                child: IconButton(
                                  iconSize: 20,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.money_off_sharp,
                                    color: colorPrincipal,
                                  ),
                                ),
                              ),
                              const Text(
                                "500",
                                style: TextStyle(
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
                    const ListTile(
                      title: Padding(
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
                        "product.description",
                        style: TextStyle(
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
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(
                        "Ingredientes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    /*   if (product.dish.ingredients != null)
                      for (final ingredient in product.dish.ingredients!)
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
                   */
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

class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        child: Image.asset('assets/images/splash.png', fit: BoxFit.cover),
      );
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
        // return Text("siy img");

        return ClipRRect(
          child: FadeInImage(
            fit: BoxFit.cover,
            image: imageProvider,
            placeholder: const AssetImage('assets/images/splash.png'),
          ),
        );
      }).toList(),
    );
  }
}
