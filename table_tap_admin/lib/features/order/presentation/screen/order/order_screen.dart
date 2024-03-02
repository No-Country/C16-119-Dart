import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/order/presentation/screen/tabs/orders_complete_tab.dart';
import 'package:table_tap_admin/features/order/presentation/screen/tabs/orders_finish_tab.dart';
import 'package:table_tap_admin/features/order/presentation/screen/tabs/orders_pending_tab.dart';
import 'package:table_tap_admin/features/order/presentation/screen/tabs/orders_processing_tab.dart';
import 'package:table_tap_admin/features/order/presentation/screen/tabs/orders_tab.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedIndex = 0;
  final List<String> _tabTitles = [
    'Todas las Ordenes',
    'Ordenes Pendientes',
    'Ordenes En proceso',
    'Ordenes Completadas',
    'Ordenes Finalizadas'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTitles[_selectedIndex]),
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Órdenes',
            backgroundColor: colorSecondary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: 'Pendientes',
            backgroundColor: colorSecondary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_bottom),
            label: 'En proceso',
            backgroundColor: colorSecondary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completadas',
            backgroundColor: colorSecondary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.price_check),
            label: 'Finalizadas',
            backgroundColor: colorSecondary,
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: colorSecondary,
        selectedItemColor: Theme.of(context).secondaryHeaderColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const OrdersTab();
      case 1:
        return const OrdersTabPending();
      case 2:
        return const OrdersTabProcessing();
      case 3:
        return const OrdersTabComplete();
      case 4:
        return const OrdersTabFinish();
      default:
        return const SizedBox();
    }
  }
}
