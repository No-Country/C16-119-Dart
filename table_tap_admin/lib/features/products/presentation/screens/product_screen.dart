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
    return const Column(
      children: [
        SizedBox(
          height: 300,
          width: 600,
          child: _ImageGallery(images: [
            "https://www.goatsontheroad.com/wp-content/uploads/2023/06/Sancocho-food-in-Colombia.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHcAO6UsKGnm6ljLkTyEDi8Dmzumf_JM22EM4OSPVaQUQJxEeEWTcowWS1RgohLri8WSY&usqp=CAU",
            "https://vecinavegetariana.com/wp-content/uploads/2022/04/Bandeja-Paisa-4.jpeg"
          ]),
        ),
        SizedBox(height: 100),
        Center(child: Text("Soy el detalle de producto")),
      ],
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
              placeholder:
                  const AssetImage('assets/loaders/loader.gif'),
            ));
      }).toList(),
    );
  }
}
