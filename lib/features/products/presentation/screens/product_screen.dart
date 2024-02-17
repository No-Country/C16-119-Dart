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
      body: Container(
        child: Center(child: Text("Soy el detalle de producto")),
      ),
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
