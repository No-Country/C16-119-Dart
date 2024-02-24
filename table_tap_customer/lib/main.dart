import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log_print/log_print.dart';
import 'package:log_print/log_print_config.dart';
import 'package:table_tap_customer/config/config.dart';
import 'firebase_options.dart';

void main() async {
  setLogPrintConfig(LogPrintConfig(colorful: true, debugMode: true));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouterProvider,
      theme: AppTheme(isDarkmode: false).getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
