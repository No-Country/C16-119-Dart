import 'package:table_tap_customer/features/scanner/domain/domain.dart';

class TableMapper {
  static TableEntity jsonToEntity(Map<String, dynamic> json) => TableEntity(
        code: json["id"],
        available: json["available"],
        number: json["number"],
      );

  static Map<String, dynamic> toJson(TableEntity table) => {
        "code": table.code,
        "available": table.available,
        "number": table.number,
      };
}
