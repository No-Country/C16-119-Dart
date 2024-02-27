import 'package:hive/hive.dart';
import 'package:table_tap_admin/config/constants/constans.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/infraestructure/reponse/product_response.dart';
import 'package:table_tap_admin/features/product/infraestructure/repository/product_repository.dart';

class HiveProductRepository implements ProductRepository {
  final Box<ProductModel> _productBox;

  HiveProductRepository()
      : _productBox = Hive.box<ProductModel>(Constants.tableProducts);

  @override
  Future<ProductResponse> createProduct(ProductResponse product) async {
    try {
      await _productBox.add(product.product!);
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
      await _productBox.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ProductResponse> getProductById(String id) async {
    return ProductResponse(
      success: false,
    );
  }

  @override
  Future<ProductResponse> getProducts() async {
    return ProductResponse(
      success: false,
    );
  }

  @override
  Future<ProductResponse> getProductsByCategory(String category) async {
    return ProductResponse(
      success: false,
    );
  }

  @override
  Future<ProductResponse> updateProduct(
    ProductResponse product,
    String id,
  ) async {
    return ProductResponse(
      success: false,
    );
  }
}
