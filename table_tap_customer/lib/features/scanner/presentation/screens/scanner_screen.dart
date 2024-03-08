import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/scanner/infrastructure/infrastructure.dart';
import 'package:table_tap_customer/features/scanner/presentation/providers/providers.dart';
import 'package:table_tap_customer/features/shared/shared.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ScannerScreenState createState() => ScannerScreenState();
}

class ScannerScreenState extends ConsumerState<ScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();

  bool hasTable = false;

  bool _existQr = false;
  final table = TablesDatasourceImpl();

  final palette = ThemeColors.palette();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void getQr() async {
    final SharedPreferences prefs = await _prefs;
    final res = prefs.getString("qr");
    _existQr = res?.isNotEmpty ?? false;
    setState(() {});
  }

  void existTable() async {
    table.getTable();
  }

  void resetQr() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("qr");
    _existQr = false;
    setState(() {});
  }

  @override
  void initState() {
    getQr();
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void foundBarcode(BarcodeCapture barcode) async {
      String qr = barcode.barcodes[0].rawValue ?? "";
      if (!hasTable && qr.isNotEmpty) {
        hasTable = true;

        try {
          final SharedPreferences prefs = await _prefs;

          prefs.setString("qr", qr);

          final tab =
              await ref.read(tableSelectedProvider.notifier).loadTable();
          bool tableavailable = tab.available;
          if (!tableavailable) {
            // MsgSnackBar.show(context, "Mesa ocupada", palette.warning);
            return;
          }
          final idTable = prefs.getString("idTable");
          _existQr = true;
          ref
              .read(tableSelectedProvider.notifier)
              .changeStatusTable(idTable ?? "", false);
          context.go(RoutesNames.orders);
          MsgSnackBar.show(context, "Mesa disponible", palette.main);
          Future.delayed(
            const Duration(seconds: 2),
            () => hasTable = false,
          );
        } catch (e) {
          print(e);
        }
      } else {
        Future.delayed(
          const Duration(seconds: 2),
          () => hasTable = false,
        );
      }
    }

    return Scaffold(
      floatingActionButton: _existQr
          ? FloatingActionButton(
              heroTag: "back",
              onPressed: () => context.go(RoutesNames.products),
              child: Icon(
                Icons.arrow_forward_ios,
                color: palette.light,
              ))
          : null,
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: palette.main,
          image: const DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          MobileScanner(
            controller: cameraController,
            onDetect: foundBarcode,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/scanner.png',
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: palette.main,
                    borderRadius: BorderRadius.circular(10)),
                width: 300,
                height: 50,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.table_restaurant,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Escanea tu Mesa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              // FloatingActionButton(
              //     heroTag: "resetQr",
              //     onPressed: resetQr,
              //     child: Icon(
              //       Icons.delete,
              //       color: palette.light,
              //     ))
            ],
          )
        ]),
      ),
    );
  }
}
