import 'package:table_tap_customer/features/scanner/domain/domain.dart';

class TableMapper {
  static Table jsonToEntity(Map<String, dynamic> json) => Table(
        code: json["id"],
        available: json["available"],
        number: json["number"],
      );

  static Map<String, dynamic> toJson(Table table) => {
        "code": table.code,
        "available": table.available,
        "number": table.number,
      };
}
