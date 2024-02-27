// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TableDetailsScreen extends StatefulWidget {
  const TableDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TableDetailsScreen> createState() => _TableDetailsScreenState();
}

class _TableDetailsScreenState extends State<TableDetailsScreen> {
  DocumentSnapshot? tableData;
  String idTable = "1708979300619";

  @override
  void initState() {
    super.initState();
    fetchTableData();
  }

  Future<void> fetchTableData() async {
    final docRef =
        FirebaseFirestore.instance.collection('tables').doc("1708979300619");
    final snapshot = await docRef.get();
    setState(() {
      tableData = snapshot;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (tableData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tableData?['id'] ?? 'Mesa Detalles'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: QrImageView(
                  data: tableData?['id'],
                  size: 200,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text('ID: ${tableData?['id'] ?? 'N/A'}'),
              // Add other fields as needed:
            //  Text('Nombre: ${tableData?['name'] ?? 'N/A'}'),
            //  Text('Capacidad: ${tableData?['capacity'] ?? 'N/A'}'),
              // ...
            
            ],
          ),
        ),
      ),
    );
  }
}
