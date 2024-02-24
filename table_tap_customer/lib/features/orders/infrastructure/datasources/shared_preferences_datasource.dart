import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:table_tap_customer/features/orders/infrastructure/mappers/order_mapper.dart';

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
            "orders": purchasedOrders.map((x) => x.toJson()).toList(),
          }));
    } catch (e) {
      print(e);
    }
  }
}
