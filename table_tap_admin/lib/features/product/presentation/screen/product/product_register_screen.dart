import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/functions/message_customer.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/product/presentation/widget/ingredients_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
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

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  bool _active = false;
  bool _prepared = false;
  final int _selectedIndex = -1;
  final List<String> _listIngredients = [];

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
            controller: _nameController,
            keyboardType: TextInputType.text,
            validator: (value) => _validate.validateName(value),
          ),
          buildSpace(),
          TextAreaCustomer(
            text: "Descripcion",
            hintText: "Ingrese descripcion",
            controller: _descriptionController,
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
              _categoryController.text = value!;
            },
          ),
          buildSpace(),
          TextFieldCustom(
            text: "Precio",
            hintText: "Ingrese precio",
            controller: _priceController,
            keyboardType: TextInputType.number,
            validator: (value) => _validate.validateLastName(value),
          ),
          buildSpace(),
          SwichCustomer(
              title: "Estado",
              available: _active,
              onChange: () {
                setState(() {
                  _active = !_active;
                });
              }),
          buildSpace(),
          SwichCustomer(
              title: "Necesita Preparacion",
              available: _prepared,
              onChange: () {
                setState(() {
                  _prepared = !_prepared;
                });
              }),
          buildSpace(),
          const Text("Ingredients"),
          IngredientsCustomer(
            listaIngredientes: _listIngredients,
            onIngredientsChanged: (value) {
              setState(() {
                _listIngredients.clear();
                _listIngredients.addAll(value);
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
    // Espera para simular una solicitud al servidor
    await Future.delayed(const Duration(seconds: 5));

    // Obtener los valores del formulario
    String name = _nameController.text;
    String description = _descriptionController.text;
    double price = double.parse(_priceController.text);
    String category = _categoryController.text;
    bool available = _active;
    bool needsPreparation = _prepared;
    List<String> ingredients = _listIngredients;

    try {
      // Crear una instancia de ProductModel
      ProductModel product = ProductModel(
        name: name,
        description: description,
        price: price,
        available: available,
        categoryId: category,
        prepared: needsPreparation,
        image: '',
        ingredients: ingredients,
      );

      // Llamar al método addProduct del ProductsNotifier
      await ref.read(productsProvider).addProduct(product);

      // Limpiar los campos del formulario
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _categoryController.text = 'seleccione'; // Restablecer la selección de categoría
      _active = false;
      _prepared = false;
      _listIngredients.clear();
      setState(() {});

      // Mostrar un mensaje de éxito
      MessageSnackBar.show(context, "Producto creado exitosamente");
    } catch (error) {
      // Mostrar un mensaje de error
      MessageSnackBar.show(
          context, "Error al crear el producto: ${error.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}



 }
