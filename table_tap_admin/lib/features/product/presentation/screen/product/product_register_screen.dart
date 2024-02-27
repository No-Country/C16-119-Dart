import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/functions/message_customer.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/product/presentation/widget/ingredients_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/category_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/image_custom.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/select_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/swich_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textarea_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class ProductAddScreen extends ConsumerStatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ProductAddScreenState();
}

class ProductAddScreenState extends ConsumerState<ProductAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValidationTextForm _validate = ValidationTextForm();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  bool active = false;
  final int _selectedIndex = -1;
  final List<String> listIngredients = [];

  final List<String> _category = [
    'seleccione',
    'Categoría 1',
    'Categoría 2',
    'Categoría 3'
  ];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              bottom: 20.0,
            ),
            child: Column(
              children: [
                buildForm(),
                const SizedBox(height: 40),
                ButtonCustomer(text: "Continue", press: handleSubmit),
                isLoading ? const LoadingCustomer() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildSpace(),
          ImageCustom(),
          buildSpace(),
          TextFieldCustom(
            text: "Nombre",
            hintText: "Ingrese nombre",
            controller: nameController,
            keyboardType: TextInputType.text,
            validator: (value) => _validate.validateName(value),
          ),
          buildSpace(),
          TextAreaCustomer(
            text: "Descripcion",
            hintText: "Ingrese descripcion",
            controller: descriptionController,
            keyboardType: TextInputType.text,
            multiLine: 3,
          ),
          buildSpace(),
          const Text("Categoria"),
          const SizedBox(height: 2),
          SelectCustomer(
            options: _category,
            initialValue: 'seleccione',
            onChanged: (value) {
              categoryController.text = value!;
            },
          ),
          buildSpace(),
          TextFieldCustom(
            text: "Precio",
            hintText: "Ingrese precio",
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: (value) => _validate.validateLastName(value),
          ),
          buildSpace(),
          SwichCustomer(
              isActive: active,
              onChange: () {
                setState(() {
                  active = !active;
                });
              }),
          buildSpace(),
          const Text("Ingredients"),
          IngredientsCustomer(
            onIngredientsChanged: (value) {
              setState(() {
                listIngredients.clear();
                listIngredients.addAll(value);
              });
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  buildSpace() {
    return const SizedBox(height: 20);
  }

  handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 5));
      print("""
      Ingredientes ${listIngredients}
      Name ${nameController.text}
      Descripcion ${descriptionController.text}
      Precio ${priceController.text}
      Categoria ${categoryController.text}
      Estado ${active}
      """);

      try {} catch (error) {
        MessageSnackBar.show(context, "${error.toString()}");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
