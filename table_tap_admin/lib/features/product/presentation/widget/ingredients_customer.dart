import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';

typedef IngredientListCallback = void Function(List<String>);

class IngredientsCustomer extends StatefulWidget {
  final IngredientListCallback? onIngredientsChanged;
  final List<String>? listaIngredientes;

  const IngredientsCustomer({
    Key? key,
    this.onIngredientsChanged,
    this.listaIngredientes,
  }) : super(key: key);

  @override
  State<IngredientsCustomer> createState() => _IngredientsCustomerState();
}

class _IngredientsCustomerState extends State<IngredientsCustomer> {
  final List<String> listIngredients = [];
  final _textFormFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.listaIngredientes != null) {
      listIngredients.addAll(widget.listaIngredientes!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_textFormFieldController.text.isNotEmpty) {
                  listIngredients.add(_textFormFieldController.text);
                  _textFormFieldController.clear();
                  widget.onIngredientsChanged?.call(
                    listIngredients,
                  );
                }
                setState(() {});
              },
            ),
          ),
          style: Theme.of(context).textTheme.bodySmall,
          controller: _textFormFieldController,
        ),
        const SizedBox(height: 10),
        listIngredients.isNotEmpty ? buildListItems() : Container(),
      ],
    );
  }

  Widget buildListItems() {
    if (listIngredients.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Lista de ingredientes"),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listIngredients.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(listIngredients[index]),
              background: Container(
                color: Colors.red.withOpacity(0.1),
              ),
              onDismissed: (direction) {
                setState(() {
                  listIngredients.removeAt(index);
                  widget.onIngredientsChanged?.call(listIngredients);
                });
              },
              child: ListTile(
                tileColor: colorTerciario.withOpacity(0.1),
                title: Row(
                  children: [
                    const Icon(Icons.check),
                    const SizedBox(width: 10),
                    Text(
                      listIngredients[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorTerciario.withOpacity(0.7),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.remove_circle_outline,
                      color: colorPrincipal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
