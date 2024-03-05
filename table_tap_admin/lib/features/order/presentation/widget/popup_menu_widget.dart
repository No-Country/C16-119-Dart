import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/order/presentation/riverpod/provider.dart';

class PopupMenuWidet extends ConsumerWidget {
  final String orderId;

  const PopupMenuWidet({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final updateProvider = ref.watch(orderRepositoryProvider);

    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: colorPrimary,
      ),
      onSelected: (dynamic value) async {
        bool restStatus =
            await updateProvider.updateOrderStatus(value, orderId);
        if (restStatus) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Orden actualizada correctamente'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al actualizar la orden'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      offset: const Offset(0, 100),
      itemBuilder: (context) {
        return _buildPopupMenuItems();
      },
    );
  }

  List<PopupMenuEntry<Object>> _buildPopupMenuItems() {
    return [
      const PopupMenuItem(
        child: Text("Seleccione opcion", style: TextStyle(fontSize: 16)),
      ),
      const PopupMenuDivider(height: 2),
      _buildOptionMenuItem("Pendiente", "pending"),
      _buildOptionMenuItem("En proceso", "processing"),
      _buildOptionMenuItem("Completo", "complete"),
      _buildOptionMenuItem("Finaliza", "finish"),
    ];
  }

  PopupMenuItem<Object> _buildOptionMenuItem(String language, String value) {
    return PopupMenuItem(
      value: value,
      child: Text(
        language,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
