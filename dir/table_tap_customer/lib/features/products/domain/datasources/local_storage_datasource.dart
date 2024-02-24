import 'package:table_tap_customer/features/orders/domain/domain.dart';

abstract class ProductsLocalStorageDatasource {

  // Future<void> toggleFavorite( Movie movie );
  
  // Future<bool> isMovieFavorite( int movieId );

  Future<List<Order>> loadOrders({ int limit = 10, offset = 0 });
  
}