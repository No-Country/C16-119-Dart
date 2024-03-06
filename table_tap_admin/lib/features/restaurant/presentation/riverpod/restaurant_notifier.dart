import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/domain/repositories/category_repository.dart';
import 'package:table_tap_admin/features/restaurant/domain/models/resturantModel.dart';
import 'package:table_tap_admin/features/restaurant/domain/repositories/resturant_repository.dart';

class RestaurantNotifier
    extends StateNotifier<AsyncValue<List<RestaurantModel>>> {
  final RestaurantRepository restaurantRepository;

  RestaurantNotifier({required this.restaurantRepository})
      : super(const AsyncLoading()) {
    list();
  }

  Future<void> list() async {
    try {
      state = await AsyncValue.guard(() async {
        final Restaurants = await restaurantRepository.getRestaurants();
        return Restaurants;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> addRestaurant(RestaurantModel restaurant) async {
    try {
      await restaurantRepository.createRestaurant(restaurant);
      await list();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateRestaurant(RestaurantModel restaurant, String id) async {
    state = const AsyncLoading();
    try {
      await restaurantRepository.updateRestaurant(restaurant, id);
      await list();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteRestaurant(String restaurantId) async {
    list();
    state = const AsyncLoading();
    try {
      await restaurantRepository.deleteRestaurant(restaurantId);
      list();
    } catch (error) {
      print(error);
    }
  }

  RestaurantModel? getRestaurantById(String restauranId) {
    if (state is AsyncData<List<RestaurantModel>>) {
      final Restaurant = (state as AsyncData<List<RestaurantModel>>).value;
      return Restaurant.firstWhere(
        (item) => item.id == restauranId,
      );
    } else {
      return null;
    }
  }
}
