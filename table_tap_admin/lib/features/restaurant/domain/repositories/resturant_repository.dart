import 'package:table_tap_admin/features/restaurant/domain/models/resturantModel.dart';

abstract class RestaurantRepository {
  // crear
  Future<RestaurantModel> createRestaurant(RestaurantModel resturant);

  // eliminar
  Future<bool> deleteRestaurant(String id);

  // editar
  Future<RestaurantModel?> updateRestaurant(
      RestaurantModel resturant, String id);

  // listar todos
  Future<List<RestaurantModel>> getRestaurants();

  // buscar por id
  Future<RestaurantModel?> getRestaurantById(String id);
}
