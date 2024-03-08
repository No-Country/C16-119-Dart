import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/restaurant/domain/datasources/resturant_datasource.dart';
import 'package:table_tap_admin/features/restaurant/domain/models/resturantModel.dart';

class RestaurantDatasourceImp implements RestaurantDatasource {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  Future<RestaurantModel> createRestaurant(RestaurantModel restaurant) async {
    final result = await _firebase.collection(Constants.tableRestaurant).add(
          restaurant.toJson(),
        );
    final data = await result.get();
    final createdRestaurant = RestaurantModel.fromJson(data.data()!, data.id);
    return createdRestaurant;
  }

  @override
  Future<bool> deleteRestaurant(String id) async {
    try {
      await _firebase.collection(Constants.tableRestaurant).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      var result = await _firebase.collection(Constants.tableRestaurant).get();
      return result.docs.map((doc) {
        final RestaurantId = doc.id;
        return RestaurantModel.fromJson(
          doc.data(),
          RestaurantId,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<RestaurantModel?> updateRestaurant(
      RestaurantModel Restaurant, String id) async {
    try {
      await _firebase
          .collection(Constants.tableRestaurant)
          .doc(id)
          .update(Restaurant.toJson());
      return Restaurant.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<RestaurantModel?> getRestaurantById(String id) async {
    try {
      var snapshot =
          await _firebase.collection(Constants.tableRestaurant).doc(id).get();
      if (snapshot.exists) {
        return RestaurantModel.fromJson(
            snapshot.data() as Map<String, dynamic>, id);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
