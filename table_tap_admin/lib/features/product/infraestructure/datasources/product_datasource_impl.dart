import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/product/domain/datasources/product_datasource.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<ProductModel> createProduct(
      ProductModel product, List<File> image) async {
    List<String> listImage = [];
    for (var i = 0; i < 2; i++) {
      String imageUrl = await uploadImageToStorage(image[0]);
      listImage.add(imageUrl);
    }
    product = product.copyWith(image: listImage);
    final result = await _firebase.collection(Constants.tableProducts).add(
          product.toJson(),
        );
    final data = await result.get();
    final createdProduct = ProductModel.fromJson(data.data()!, data.id);
    return createdProduct;
  }

  @override
  Future<bool> deleteProduct(String id) async {
    try {
      await _firebase.collection(Constants.tableProducts).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    try {
      var snapshot =
          await _firebase.collection(Constants.tableProducts).doc(id).get();
      if (snapshot.exists) {
        return ProductModel.fromJson(
            snapshot.data() as Map<String, dynamic>, id);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      var result = await _firebase.collection(Constants.tableProducts).get();
      return result.docs.map((doc) {
        final productId = doc.id;

        return ProductModel.fromJson(
            doc.data() as Map<String, dynamic>, productId);
      }).toList();
    } catch (e) {
      print("Lista de productos ${e.toString()}");

      return [];
    }
  }

  @override
  Future<ProductModel?> updateProduct(
      ProductModel product, String id, List<File> image) async {
    List<String> listImage = [];

    if (image.isNotEmpty) {
      for (var i = 0; i < 2; i++) {
        String imageUrl = await uploadImageToStorage(image[0]);
        listImage.add(imageUrl);
      }
      product = product.copyWith(image: listImage);
    }

    try {
      await _firebase
          .collection(Constants.tableProducts)
          .doc(id)
          .update(product.toJson());
      return product.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  Future<String> uploadImageToStorage(File image) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      TaskSnapshot snapshot = await _firebaseStorage
          .ref()
          .child('product_images/$imageName')
          .putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error al subir la imagen: $e');
      throw Exception('Error al subir la imagen: $e');
    }
  }
}
