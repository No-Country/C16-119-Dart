import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log_print/log_print.dart';
import 'package:log_print/log_print_config.dart';
import 'package:table_tap_admin/config/router.dart';
import 'package:table_tap_admin/config/theme.dart';

import 'firebase_options.dart';

void main() async {
  setLogPrintConfig(LogPrintConfig(colorful: true, debugMode: true));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final thema = AppTheme().getTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouterProvider,
      theme: thema,
      debugShowCheckedModeBanner: false,
    );
  }
}
