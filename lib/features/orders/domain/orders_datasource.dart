
import 'package:table_tap_customer/features/orders/domain/domain.dart';

abstract class ProductsRepository {

  Future<List<Order>> getOrdersByPage({ int limit = 10, int offset = 0 });
  Future<Order> getOrderById(String id);

  Future<List<Order>> searchProductByTerm( String term );
  
  Future<Order> createUpdateProduct( Map<String,dynamic> productLike );


}