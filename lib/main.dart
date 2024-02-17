import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:log_print/log_print.dart';
import 'package:log_print/log_print_config.dart';
import 'package:table_tap_customer/features/products/products.dart';


import 'firebase_options.dart';

void main() async {
  setLogPrintConfig(LogPrintConfig(colorful: true, debugMode: true));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ProductScreen()
      ),
    );
  }
}
