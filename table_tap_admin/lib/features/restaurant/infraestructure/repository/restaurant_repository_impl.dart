import 'package:table_tap_admin/features/restaurant/domain/datasources/resturant_datasource.dart';
import 'package:table_tap_admin/features/restaurant/domain/models/resturantModel.dart';
import 'package:table_tap_admin/features/restaurant/domain/repositories/resturant_repository.dart';

class RestaurantRepositoryImp implements RestaurantRepository {
  final RestaurantDatasource restaurantDatasource;

  RestaurantRepositoryImp({required this.restaurantDatasource});

  @override
  Future<RestaurantModel> createRestaurant(RestaurantModel resturant) {
    return restaurantDatasource.createRestaurant(resturant);
  }

  @override
  Future<bool> deleteRestaurant(String id) {
    return restaurantDatasource.deleteRestaurant(id);
  }

  @override
  Future<RestaurantModel?> getRestaurantById(String id) {
    return restaurantDatasource.getRestaurantById(id);
  }

  @override
  Future<List<RestaurantModel>> getRestaurants() {
    return restaurantDatasource.getRestaurants();
  }

  @override
  Future<RestaurantModel?> updateRestaurant(
      RestaurantModel resturant, String id) {
    return restaurantDatasource.updateRestaurant(resturant, id);
  }
}
