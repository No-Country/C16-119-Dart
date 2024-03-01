import 'dart:convert';
import 'package:log_print/log_print.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:table_tap_customer/features/orders/infrastructure/infrastructure.dart';

class KeysSharedPreferences {
  static const paidOrders = "paidOrders";
}

class SharedPreferencesDatasourceImpl extends LocalStorageDatasource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> saveOrder(Order order) async {
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.setString(KeysSharedPreferences.paidOrders,
          jsonEncode({"order": OrderMapper.toJson(order)}));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Order> loadOrder() async {
    try {
      final SharedPreferences prefs = await _prefs;
      final res = prefs.getString(KeysSharedPreferences.paidOrders);
      final resDecode = jsonDecode(res!)["order"];
      return OrderMapper.jsonToEntity(resDecode);
    } catch (e) {
      print(e);
      return Order(
          idOrder: "",
          nameCustomer: "",
          priceTotal: 0,
          timeTotal: 0,
          amountTotal: 0,
          dishes: []);
    }
  }

  @override
  Future<List<Order>> loadOrders({int limit = 10, offset = 0}) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final res = prefs.getString(KeysSharedPreferences.paidOrders);
      final resDecode = jsonDecode(res!)["orders"];
      final dataToEntity =
          resDecode.map((x) => OrderMapper.jsonToEntity(x)).toList();
      //Todo
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<void> saveOrders(List<Order> purchasedOrders) async {
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.setString(
          KeysSharedPreferences.paidOrders,
          jsonEncode({
            "orders":
                purchasedOrders.map((x) => OrderMapper.toJson(x)).toList(),
          }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteOrder() async {
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.remove(KeysSharedPreferences.paidOrders);
    } catch (e) {
      print(e);
    }
  }
}
