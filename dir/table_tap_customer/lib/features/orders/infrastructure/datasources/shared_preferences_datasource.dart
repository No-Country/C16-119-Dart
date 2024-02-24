// import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
// import 'package:cinemapedia/domain/entities/movie.dart';
// import 'package:isar/isar.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';

class KeysSharedPreferences {
  static const paidOrders = "paidOrders";
}

class SharedPreferencesDatasource extends LocalStorageDatasource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<List<Order>> loadOrders({int limit = 10, offset = 0}) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final res = prefs.getString(KeysSharedPreferences.paidOrders);
      final resDecode = jsonDecode(res!);
      print(resDecode);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<void> saveOrders(List<Order> newOrders) async {
    print(newOrders.toString());
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.setString(
          KeysSharedPreferences.paidOrders,
          jsonEncode({
            "orders": [
              Order(
                  idOrder: "1",
                  nameCustomer: "pepe",
                  priceTotal: 200,
                  timeTotal: 34,
                  amountTotal: 2,
                  dishes: []).toString()
            ]
          }));
    } catch (e) {
      print(e);
    }
  }

  // @override
  // Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {

  //   final isar = await db;

  //   return isar.movies.where()
  //     .offset(offset)
  //     .limit(limit)
  //     .findAll();
  // }

  // IsarDatasource() {
  //   db = openDB();
  // }

  // Future<Isar> openDB() async {
  //   if ( Isar.instanceNames.isEmpty ) {
  //     return await Isar.open([ MovieSchema ], inspector: true );
  //   }

  //   return Future.value(Isar.getInstance());
  // }

  // @override
  // Future<bool> isMovieFavorite(int movieId) async {
  //   final isar = await db;

  //   final Movie? isFavoriteMovie = await isar.movies
  //     .filter()
  //     .idEqualTo(movieId)
  //     .findFirst();

  //   return isFavoriteMovie != null;
  // }

  // @override
  // Future<void> toggleFavorite(Movie movie) async {

  //   final isar = await db;

  //   final favoriteMovie = await isar.movies
  //     .filter()
  //     .idEqualTo(movie.id)
  //     .findFirst();

  //   if ( favoriteMovie != null ) {
  //     // Borrar
  //     isar.writeTxnSync(() => isar.movies.deleteSync( favoriteMovie.isarId! ));
  //     return;
  //   }

  //   // Insertar
  //   isar.writeTxnSync(() => isar.movies.putSync(movie));

  // }
}
