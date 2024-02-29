import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/swich_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class CategoryAddModal extends ConsumerStatefulWidget {
  const CategoryAddModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CategoryAddModalState();
}

class CategoryAddModalState extends ConsumerState<CategoryAddModal> {
  final ValidationTextForm _validate = ValidationTextForm();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  bool _active = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Nueva categoria",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 25),
          Form(
            key: _formkey,
            child: Column(
              children: [
                TextFieldCustom(
                  controller: _nameController,
                  hintText: "Ingrese una categoria",
                  text: "Nombre",
                  validator: (value) => _validate.validateIsTextEmpity(value),
                ),
                const SizedBox(height: 20),
                SwichCustomer(
                  available: _active,
                  onChange: () {
                    setState(() {
                      _active = !_active;
                    });
                  },
                  title: "Estado",
                ),
                const SizedBox(height: 15.0),
                ButtonCustomer(press: handleSubmit, text: "Guardar"),
              ],
            ),
          ),
          _isLoading ? const LoadingCustomer() : Container(),
        ],
      ),
    );
  }

  handleSubmit() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String name = _nameController.text;
        bool available = _active;

        final category = CategoryModel(name: name, status: available);
        await ref.read(categoriesProvider).addCategory(category);
        _nameController.clear();
        _active = false;
        print(
            "\n\nCategoria :$name\nEsatdo ${available ? 'Activo' : 'Desactivo'}");
      } catch (e) {
        print("${e.toString()}");
      } finally {
        setState(() {
          _isLoading = false; // Cambiado a false
        });
      }
    }
  }
}
