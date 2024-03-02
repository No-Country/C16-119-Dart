import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/scanner/domain/domain.dart';
import 'package:table_tap_customer/features/scanner/presentation/providers/providers.dart';
import 'package:table_tap_customer/features/shared/shared.dart';

class TablesScreen extends ConsumerStatefulWidget {
  const TablesScreen({super.key});

  @override
  TablesScreenState createState() => TablesScreenState();
}

class TablesScreenState extends ConsumerState<TablesScreen> {
  String dropdownCode = '';
  String dropdownValue = '';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _existQr = false;
  void getQr() async {
    final SharedPreferences prefs = await _prefs;
    final res = prefs.getString("qr");
    _existQr = res?.isNotEmpty ?? false;
    setState(() {});
  }

  @override
  void initState() {
    getQr();
    ref.read(tablesListProvider.notifier).loadNextPage();
    super.initState();
  }

  void selectTable() async {
    try {
      final SharedPreferences prefs = await _prefs;

      prefs.setString("qr", dropdownCode);
      final tab = await ref.read(tableSelectedProvider.notifier).loadTable();
      bool tableavailable = tab.available;
      if (!tableavailable) {
        return;
      }
      final idTable = prefs.getString("idTable");
      ref
          .read(tableSelectedProvider.notifier)
          .changeStatusTable(idTable ?? "", false);
      context.go(RoutesNames.orders);
      MsgSnackBar.show(context, "Mesa disponible", palette.main);
    } catch (e) {
      print(e);
    }
  }

  final palette = ThemeColors.palette();
  @override
  Widget build(BuildContext context) {
    List tables = ref.watch(tablesListProvider);
    // tables = [TableEntity(code: "Selecciona tu mesa", number: 0), ...tables];
    return Scaffold(
      floatingActionButton: _existQr
          ? FloatingActionButton(
              backgroundColor: palette.white,
              heroTag: "back",
              onPressed: () => context.go(RoutesNames.products),
              child: Icon(
                Icons.arrow_forward_ios,
                color: palette.main,
              ))
          : null,
      body: Container(
        color: palette.main,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: palette.white, //background color of dropdown button
                    border: Border.all(
                        color: Colors.black38,
                        width: 3), //border of dropdown button
                    borderRadius: BorderRadius.circular(
                        10), //border raiuds of dropdown button
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(dropdownValue.isNotEmpty
                          ? "Mesa $dropdownValue seleccionada"
                          : "Selecciona tu Mesa"),
                    ),
                    // value: ,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    selectedItemBuilder: (BuildContext context) {
                      return tables.map((table) {
                        return Text(
                          "Mesa ${table.number}",
                          style: TextStyle(color: palette.main),
                        );
                      }).toList();
                    },
                    // Array list of items
                    items: tables.map((table) {
                      return DropdownMenuItem(
                        value: {"code": table.code, "number": table.number},
                        child: Text("Mesa ${table.number}"),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = (newValue?["number"]).toString();
                        dropdownCode = newValue?["code"];
                      });
                    },
                    // onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: dropdownValue.isNotEmpty
                    ? () {
                        selectTable();
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          dropdownValue.isEmpty ? palette.light : palette.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: 200,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.table_restaurant,
                        color: palette.main,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Selecciona tu Mesa",
                        style: TextStyle(color: palette.main),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
