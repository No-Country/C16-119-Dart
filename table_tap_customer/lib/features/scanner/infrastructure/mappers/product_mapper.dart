import 'package:table_tap_customer/features/scanner/domain/domain.dart';

class ProductMapper {
  static Table jsonToEntity(Map<String, dynamic> json) => Table(
      code: json["id"],
      available: json["available"],
      );
}
