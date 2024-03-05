import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogError.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogSucces.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/swich_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class CategoryEditModal extends ConsumerStatefulWidget {
  final String categoryId;

  const CategoryEditModal(
    this.categoryId, {
    Key? key,
  }) : super(key: key);

  @override
  CategoryEditModalState createState() => CategoryEditModalState();
}

class CategoryEditModalState extends ConsumerState<CategoryEditModal> {
  final ValidationTextForm _validate = ValidationTextForm();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  bool _active = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    handleInitText();
  }

  handleInitText() async {
    try {
      final categoryAsync = await ref
          .read(categoriesProvider.notifier)
          .getCategotyById(widget.categoryId);
      if (categoryAsync != null) {
        _nameController.text = categoryAsync.name;
        _active = categoryAsync.status!;
        setState(() {});
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Editar categoria",
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
                  keyboardType: TextInputType.text,
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
        //obtengo los datos de a enviar
        String name = _nameController.text;
        bool available = _active;
        // crea instancia de la categoria
        final categoriesAsync = ref.watch(categoriesProvider.notifier);
        // crea modelo category
        final modelCategory = CategoryModel(name: name, status: available);
        // se envia a la base de datos
        await categoriesAsync.updateCategory(modelCategory, widget.categoryId);
        // limpio los campos
        cerrarModal(context);
        messageDialogSucces(
            context, "Se actualizo con exito", "Categoria $name");
      } catch (e) {
        messageDialogError(context, "Error ${e.toString()}", "");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void cerrarModal(BuildContext context) {
    context.pop();
  }
}
