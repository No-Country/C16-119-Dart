import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';

class TableRegisterScreen extends StatefulWidget {
  const TableRegisterScreen({Key? key}) : super(key: key);

  @override
  State<TableRegisterScreen> createState() => _TableRegisterScreenState();
}

class _TableRegisterScreenState extends State<TableRegisterScreen> {
  String data = "";

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> generateQrCode() async {
    // Generate a unique ID for the table
    final tableId = '${DateTime.now().millisecondsSinceEpoch}';
    data = tableId;

    // Save table data to Firebase
    final tableRef =
        FirebaseFirestore.instance.collection('tables').doc(tableId);
    await tableRef.set({
      'id': tableId,
      // Add other table details as needed
    });
    print("El codgo es $tableId");

    setState(() {}); // Update UI to display the generated QR code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: data.isEmpty
                ? const Text('Genera un código QR para la mesa')
                : QrImageView(
                    data: data,
                    backgroundColor: Colors.white,
                    version: QrVersions.auto,
                    size: 300.0,
                  ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 300,
            child: ButtonCustomer(
              text: "Generar code QR",
              press: generateQrCode,
            ),
          ),
        ],
      ),
    );
  }
}
