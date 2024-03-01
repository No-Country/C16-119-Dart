import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';
import 'package:table_tap_customer/features/products/infrastructure/infrastructure.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    try {
      CollectionReference collectionReferenceProducts =
          db.collection(DbNames.products);
      QuerySnapshot queryProducts = await collectionReferenceProducts
          .where("available", isEqualTo: true)
          .get();
      List<Product> productsList = [];

      for (var element in queryProducts.docs) {
        Map<dynamic, dynamic> res = element.data() as Map;
        res = {...res, "id": element.id};
        productsList
            .add(ProductMapper.jsonToEntity(res.map((key, value) => MapEntry(
                  key,
                  value,
                ))));
      }
      return productsList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
    // try {
    //   final String? productId = productLike['id'];
    //   final String method = (productId == null) ? 'POST' : 'PATCH';
    //   final String url =
    //       (productId == null) ? '/products' : '/products/$productId';

    //   productLike.remove('id');
    //   // productLike['images'] = await _uploadPhotos( productLike['images'] );

    //   final response = await dio.request(url,
    //       data: productLike, options: Options(method: method));

    //   final product = ProductMapper.jsonToEntity(response.data);
    //   return product;
    // } catch (e) {
    //   throw Exception();
    // }
  }

  @override
  Future<Product> getProductById(String id) async {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
    // try {
    //   final response = await dio.get('/products/$id');
    //   final product = ProductMapper.jsonToEntity(response.data);
    //   return product;
    // } on DioError catch (e) {
    //   if (e.response!.statusCode == 404) throw ProductNotFound();
    //   throw Exception();
    // } catch (e) {
    //   throw Exception();
    // }
  }
  
  @override
  Future<Product> createProduct(Map<String, dynamic> productLike) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }
  
  @override
  Future<Product> updateProduct(Map<String, dynamic> productLike, String idProduct) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
