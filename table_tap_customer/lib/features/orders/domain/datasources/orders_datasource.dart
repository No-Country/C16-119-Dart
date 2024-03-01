
abstract class OrdersDatasource {
  Future<bool> createOrder(Map<String, dynamic> orderLike);

  Future<bool> updateOrder(Map<String, dynamic> orderLike, String idOrder);
}
