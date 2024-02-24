import 'package:table_tap_customer/features/orders/domain/domain.dart';

abstract class LocalStorageRepository {
  Future<void> saveOrders(List<Order> newOrders);

  // Future<bool> isMovieFavorite( int movieId );

  Future<List<Order>> loadOrders({int limit = 10, offset = 0});
}
