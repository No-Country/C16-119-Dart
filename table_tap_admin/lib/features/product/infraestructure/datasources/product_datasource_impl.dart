import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/product/domain/datasources/product_datasource.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    final result = await _firebase.collection(Constants.tableProducts).add(
          product.toJson(),
        );
    final data = await result.get();
    final createdProduct = ProductModel.fromJson(data.data()!, data.id);
    return createdProduct;
  }

  @override
  Future<bool> deleteProduct(String id) async {
    print("Eliminando producto db $id");
    try {
      await _firebase.collection(Constants.tableProducts).doc(id).delete();
      return true;
    } catch (e) {
      print("Eliminando producto errror ${e.toString()}");

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
      print('Error al obtener producto por ID: $e');
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
      print('Error al obtener productos: $e');
      return [];
    }
  }

  @override
  Future<ProductModel?> updateProduct(ProductModel product, String id) async {
    try {
      await _firebase
          .collection(Constants.tableProducts)
          .doc(id)
          .update(product.toJson());
      return product.copyWith(id: id);
    } catch (e) {
      print('Error al actualizar producto: $e');
      return null;
    }
  }
}
