import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_admin/config/constants/constans.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/infraestructure/reponse/product_response.dart';
import 'package:table_tap_admin/features/product/infraestructure/repository/product_repository.dart';

class FirebaseProductRepository implements ProductRepository {
  final FirebaseFirestore _firestore;

  FirebaseProductRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<ProductResponse> createProduct(ProductResponse product) async {
    try {
      await _firestore
          .collection(Constants.tableProducts)
          .add(product.product!.toJson());
      return const ProductResponse(success: true);
    } catch (e) {
      return ProductResponse(
        success: false,
        errorMessage: "error ${e.toString()}",
      );
    }
  }

  @override
  Future<ProductResponse> updateProduct(
    ProductResponse product,
    String id,
  ) async {
    try {
      await _firestore.collection(Constants.tableProducts).doc(id).update(
            product.product!.toJson(),
          );
      return const ProductResponse(
        success: true,
      );
    } catch (e) {
      return ProductResponse(
        success: false,
        errorMessage: "error ${e.toString()}",
      );
    }
  }

  @override
  Future<bool> deleteProduct(String id) async {
    try {
      await _firestore.collection(Constants.tableProducts).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ProductResponse> getProductById(String id) async {
    try {
      final docSnapshot =
          await _firestore.collection(Constants.tableProducts).doc(id).get();
      final product = ProductModel.fromJson(docSnapshot.data()!);
      return ProductResponse(
        success: true,
        product: product,
      );
    } catch (e) {
      return ProductResponse(
        success: false,
        errorMessage: "error ${e.toString()}",
      );
    }
  }

  @override
  Future<ProductResponse> getProducts() async {
    try {
      final query = await _firestore.collection(Constants.tableProducts).get();
      final products =
          query.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();

      return ProductResponse(
        success: true,
        products: products,
      );
    } catch (e) {
      return ProductResponse(
        success: false,
        errorMessage: "error ${e.toString()}",
      );
    }
  }

  @override
  Future<ProductResponse> getProductsByCategory(String categorId) async {
    try {
      final query = await _firestore
          .collection(Constants.tableProducts)
          .where('id', isEqualTo: categorId)
          .get();
      final products =
          query.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();

      return ProductResponse(
        success: true,
        products: products,
      );
    } catch (e) {
      return ProductResponse(
        success: false,
        errorMessage: "error ${e.toString()}",
      );
    }
  }
}
