import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> tablesStream;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    tablesStream = FirebaseFirestore.instance.collection('tables').snapshots();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: IconButton(
        color: colorSecondary,
        onPressed: () {
          context.push(RoutesConstants.tableAdd);
        },
        icon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: const Icon(Icons.add, color: colorTerciario),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: tablesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching tables'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final tables = snapshot.data!.docs;

          return ListView.builder(
            itemCount: tables.length,
            itemBuilder: (context, index) {
              final tableData = tables[index].data();
              final tableId = tableData.toString();

              return ListTile(
                title: Column(
                  children: [
                    Text(tableId),
                    IconButton(
                      onPressed: () {
                        context.push(RoutesConstants.tableDetail);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
                trailing: QrImageView(
                  data: tableId,
                  size: 100,
                  backgroundColor: Colors.white,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
