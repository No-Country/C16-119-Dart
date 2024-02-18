import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {
          // if (productState.product == null) return;

          // ref
          //     .read(productFormProvider(productState.product!).notifier)
          //     .onFormSubmit()
          //     .then((value) {
          //   if (!value) return;
          //   showSnackbar(context);
          // });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ProductView extends StatelessWidget {
  const _ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        SizedBox(
          height: 300,
          width: 600,
          child: _ImageGallery(images: [
            "https://i.ibb.co/m6PqGyG/Food-Picture.png",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHcAO6UsKGnm6ljLkTyEDi8Dmzumf_JM22EM4OSPVaQUQJxEeEWTcowWS1RgohLri8WSY&usqp=CAU",
            "https://vecinavegetariana.com/wp-content/uploads/2022/04/Bandeja-Paisa-4.jpeg"
          ]),
        ),
        // SizedBox(height: 100),
        _ProductDetail(),
      ],
    );
  }
}

class _ProductDetail extends StatelessWidget {
  const _ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const ListTile(
                      title: Text(
                        "Cacao Maca Walnut Milk",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        "Food - 60 mins",
                        style: TextStyle(fontSize: 16),
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
                                const Text(
                                  "Restaurant name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            Row(children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: const Color(0xff1FCC79),
                                child: IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.favorite,
                                        color: Color(0xffE3FFF8))),
                              ),
                              const Text(
                                "60 likes",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ])
                          ],
                        ),
                        // const ImageIcon(NetworkImage(
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Divider(),
                    ),
                    const ListTile(
                      title: Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        "Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      title: Divider(),
                    ),
                    const ListTile(
                      title: Text(
                        "Ingredients",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffE3FFF8),
                          child: Icon(Icons.check, color: Color(0xff1FCC79))),
                      subtitle: Text(
                        "4 Eggs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
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
          // borderRadius: const BorderRadius.all(Radius.circular(20)),
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
            // borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: FadeInImage(
          fit: BoxFit.cover,
          image: imageProvider,
          placeholder: const AssetImage('assets/loaders/loader.gif'),
        ));
      }).toList(),
    );
  }
}
