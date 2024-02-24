// import 'dart:math';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DbService {
//   var path = "";

//   Future<Database> _openDb() async {
//     final dbPath = await getDatabasesPath();
//     path = join(dbPath, "tableTap.db");

//     return openDatabase(path, onCreate: (db, version) async {
//       await db
//           .execute("CREATE TABLE orders (id INTEGER PRIMARY KEY, name TEXT)");
//     }, version: 1);
//   }

//   Future<void> addData() async {
//     final db = await _openDb();
//     try {
//       await db.insert(
//           "orders",
//           {
//             "name": "paco",
//             "data": [
//               {"asd"}
//             ]
//           },
//           conflictAlgorithm: ConflictAlgorithm.ignore);
//       print(" insert paco");
//     } catch (e) {
//       print(e);
//     }
//     await db.close();
//   }

//   Future<void> getData() async {
//     final db = await _openDb();
//     final data = await db.query("orders");
//     print(data);
//     await db.close();
//   }
// }

