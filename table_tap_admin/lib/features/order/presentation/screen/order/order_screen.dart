import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedIndex = 0; // Índice de la pestaña seleccionada

  final List<Widget> _widgetOptions = <Widget>[
    // Contenido para la pestaña de órdenes
    ListView.builder(
      itemCount: 20, // Cantidad de elementos en la lista
      itemBuilder: (context, index) {
        // Construir cada elemento de la lista
        return ListTile(
          leading: Icon(Icons.list), // Icono a la izquierda del elemento
          title: Text('Orden $index'), // Texto principal del elemento
          subtitle: Text('Descripción de la orden $index'), // Subtítulo del elemento
          trailing: Icon(Icons.arrow_forward), // Icono a la derecha del elemento
          onTap: () {
            // Acción al presionar el elemento de la lista
            print('Tapped on Order $index');
          },
        );
      },
    ),
    // Contenido para la pestaña de pendientes
    Center(
      child: Text('Pendientes'),
    ),
    // Contenido para la pestaña de en proceso
    Center(
      child: Text('En proceso'),
    ),
    // Contenido para la pestaña de finalizadas
    Center(
      child: Text('Finalizadas'),
    ),
    // Contenido para la pestaña de configuración
    Center(
      child: Text('Configuración'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualizar el índice de la pestaña seleccionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis órdenes'),
      ),
      body: _widgetOptions[_selectedIndex], // Mostrar el contenido de la pestaña seleccionada
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
            label: 'Finalizadas',
            backgroundColor: colorSecondary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
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
}
