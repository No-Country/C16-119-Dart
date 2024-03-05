import 'package:flutter/material.dart';

class DeleteDismissible<T> extends StatelessWidget {
  final T item;
  final Function(T) onDismissed;
  final Widget child;

  const DeleteDismissible({
    required this.item,
    required this.onDismissed,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.toString()), // Key basada en el valor del elemento
      background: Container(
        color: Colors.red,
        child: const Center(
          child: Text(
            'Eliminar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      direction: DismissDirection.startToEnd, // Deslizar hacia la izquierda para eliminar
      confirmDismiss: (_) async {
        // Mostrar un diálogo de confirmación
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirmar eliminación"),
            content: const Text(
                "¿Estás seguro de que quieres eliminar este elemento?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Eliminar"),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDismissed(item), // Llamar a la función de eliminación cuando se desliza
      child: child,
    );
  }
}
