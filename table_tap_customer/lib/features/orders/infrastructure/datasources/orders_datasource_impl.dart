import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:log_print/log_print.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:firebase_database/firebase_database.dart';

/// The `DbNames` class in Dart contains static constants for database table names such as products,
/// users, orders, and tables.
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class OrdersDatasourceImpl extends OrdersDatasource {
  FirebaseFirestore db = FirebaseFirestore.instance;
  DatabaseReference dbRT = FirebaseDatabase.instance.ref();

  @override
  Future<bool> createOrder(Map<String, dynamic> orderLike) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final idTable = prefs.getString("idTable");
      // for (var element in [
      //   {
      //     "available": true,
      //     "category": "Fuertes",
      //     "description":
      //         "Costillas de cerdo de 600 g. con nuestra salsa BBQ, parrillado a la perfección, acompañada de papas y ensalada",
      //     "ingredients": ["carne", "papas cascos", "ensalada"],
      //     "likes": 487,
      //     "name": "Costillas",
      //     "image": [
      //       "https://images.pexels.com/photos/410648/pexels-photo-410648.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      //       "https://images.pexels.com/photos/5410460/pexels-photo-5410460.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
      //       "https://images.pexels.com/photos/5175620/pexels-photo-5175620.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
      //     ],
      //     "price": 30,
      //     "time": 25,
      //   },
      //   {
      //     "available": true,
      //     "category": "Fuertes",
      //     "description":
      //         "Nuestra hamburguesa Angus cubierta con queso mozzarella y cheddar, con doble carne y tiritas de cebolla crujiente, bañadas con aderezo ranch.",
      //     "ingredients": [
      //       "cebolla",
      //       "queso",
      //       "verduras",
      //       "carne",
      //       "salsas",
      //       "pan",
      //       "papas",
      //     ],
      //     "likes": 162,
      //     "name": "Hamburguesa",
      //     "image": [
      //       "https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=600",
      //       "https://images.pexels.com/photos/15344189/pexels-photo-15344189/free-photo-of-burger-in-a-portuguese-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600",
      //     ],
      //     "price": 12,
      //     "time": 20,
      //   },
      //   {
      //     "available": true,
      //     "category": "Fuertes",
      //     "description":
      //         "La tortilla es una preparación fina y redonda hecha de masa de maíz, de entre 12 y 25 cm de diámetro. También se elaboran, aunque menos comúnmente, tortillas de harina de trigo, e incluso de nopal",
      //     "ingredients": ["tortilla", "verduras", "carne", "salsas"],
      //     "likes": 427,
      //     "name": "Tacos",
      //     "image": [
      //       "https://images.pexels.com/photos/2092507/pexels-photo-2092507.jpeg?auto=compress&cs=tinysrgb&w=600",
      //       "https://images.pexels.com/photos/2087748/pexels-photo-2087748.jpeg?auto=compress&cs=tinysrgb&w=600",
      //     ],
      //     "price": 5,
      //     "time": 15,
      //   },
      //   {
      //     "available": true,
      //     "category": "Postres",
      //     "description":
      //         "Cheescake con bizcocho de vainilla base de galleta y cubierta con salsa y frutos rojos.",
      //     "ingredients": [
      //       "frutos rojos",
      //       "leche",
      //       "azucar",
      //       "huevos",
      //       "harina"
      //     ],
      //     "likes": 756,
      //     "name": "Cheesecake de futos rojos",
      //     "image": [
      //       "https://images.pexels.com/photos/1126359/pexels-photo-1126359.jpeg?auto=compress&cs=tinysrgb&w=600",
      //       "https://media.istockphoto.com/id/1154062451/photo/berry-cheesecake-slice-fresh-frozen-red-fruits-and-cheese-cake-slice-tasty-dessert.jpg?s=612x612&w=0&k=20&c=A-i90zHogb0sZBIcMoSG6P3_Vq8clFIZWY64hwwsgc0=",
      //     ],
      //     "price": 10,
      //     "time": 5,
      //   },
      //   {
      //     "available": true,
      //     "category": "Postres",
      //     "description": "",
      //     "ingredients": [
      //       "cacao",
      //       "leche",
      //       "azucar",
      //       "huevos",
      //       "harina",
      //       "chips"
      //     ],
      //     "likes": 789,
      //     "name": "Postre de chocolate",
      //     "image": [
      //       "https://images.pexels.com/photos/2373520/pexels-photo-2373520.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      //       "https://media.istockphoto.com/id/1852561807/photo/delicious-homemade-chocolate-christmas-cake-with-nuts-and-berries-on-the-top-fresh.jpg?s=612x612&w=0&k=20&c=Ous4Atl1haMP8uGoDd4QhMAt4BTw7vM_9h0uEKGUh1g=",
      //     ],
      //     "price": 8,
      //     "time": 5,
      //   },
      //   {
      //     "available": true,
      //     "category": "Postres",
      //     "description": "",
      //     "ingredients": [
      //       "maracuya",
      //       "leche",
      //       "azucar",
      //       "huevos",
      //       "harina",
      //       "leche condensada",
      //     ],
      //     "likes": 566,
      //     "name": "Flan de maracuya",
      //     "image": [
      //       "https://images.pexels.com/photos/15726223/pexels-photo-15726223/free-photo-of-pudding-with-sauce-on-plate.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      //       "https://images.pexels.com/photos/15813613/pexels-photo-15813613/free-photo-of-half-of-a-cupcake-with-cream-inside.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
      //     ],
      //     "price": 9,
      //     "time": 5,
      //   },
      //   {
      //     "available": true,
      //     "category": "Bebidas",
      //     "description": "Bebida azucarada",
      //     "ingredients": [],
      //     "likes": 122,
      //     "name": "Coca Cola",
      //     "image": [
      //       "https://images.pexels.com/photos/1561147/pexels-photo-1561147.jpeg?auto=compress&cs=tinysrgb&w=600",
      //     ],
      //     "price": 3,
      //     "time": 5,
      //   },
      //   {
      //     "available": true,
      //     "category": "Bebidas",
      //     "description": "Bebida natural a base de naranjas",
      //     "ingredients": ["agua", "naranjas", "azucar"],
      //     "likes": 345,
      //     "name": "Jugo de naranja",
      //     "image": [
      //       "https://images.pexels.com/photos/338713/pexels-photo-338713.jpeg?auto=compress&cs=tinysrgb&w=600",
      //     ],
      //     "price": 5,
      //     "time": 5,
      //   },
      //   {
      //     "available": true,
      //     "category": "Bebidas",
      //     "description": "Bedida caliente a base de cafe recien molido",
      //     "ingredients": ["leche", "azucar", "cafe"],
      //     "likes": 345,
      //     "name": "Cafe",
      //     "image": [
      //       "https://images.pexels.com/photos/4109850/pexels-photo-4109850.jpeg?auto=compress&cs=tinysrgb&w=600",
      //       "https://images.pexels.com/photos/16430951/pexels-photo-16430951/free-photo-of-coffee-cup-on-plate-with-spoon.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
      //     ],
      //     "price": 4,
      //     "time": 10,
      //   },
      // ]) {
      //   await db.collection(DbNames.products).add(element);
      // }

      DocumentReference res = await db
          .collection(DbNames.orders)
          .add({...orderLike, "idTable": idTable});
      DatabaseReference resDbRT = dbRT.child(DbRTNames.orders).push();
      resDbRT.set({
        ...orderLike,
        "idOrder": res.id,
        "status": "pending",
        "idTable": idTable
      });

      // resDbRT.key! id del real time

      // DatabaseEvent dataSnapshot =
      //     await dbRT.child(DbRTNames.orders).child(resDbRT.key!).once();
      // LogPrint("${dataSnapshot.snapshot.value}", type: LogPrintType.info);

      // final r = await dbRT.child(DbRTNames.orders).equalTo(resDbRT.key).get();

      // final r = await dbRealTime
      //     .child('orders').get();
      // .push()
      // LogPrint("-> ${docRef.id}", type: LogPrintType.info);
      return true;
    } catch (e) {
      LogPrint("${e}", type: LogPrintType.warning);
      return false;
    }
  }

  @override
  Future<bool> updateOrder(
      Map<String, dynamic> orderLike, String idOrder) async {
    throw UnimplementedError();
  }
}
