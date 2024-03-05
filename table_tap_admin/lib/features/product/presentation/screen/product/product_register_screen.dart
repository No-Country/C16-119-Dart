import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/functions/message_customer.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/product/presentation/widget/ingredients_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogError.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogSucces.dart';
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
  final _timeController = TextEditingController();
  bool _active = false;
  bool _prepared = false;
  final List<String> _listIngredients = [];
  final List<CategoryModel> _listCategory = [];
  String initialImageUrl = "";
  bool isLoading = false;
  File? _image;

  void handleImageChanged(File imageFile) {
    setState(() {
      _image = imageFile;
    });
  }

  @override
  void initState() {
    super.initState();
    handleListcategories();
  }

  handleListcategories() async {
    final categoryNotifier = ref.read(categoriesProvider.notifier);
    final result = categoryNotifier.getCategoryByStatus();
    setState(() {
      _listCategory.clear();
      _listCategory.addAll(result!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Crear producto"),

      ),
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
          ImageCustom(
            initialImageUrl: initialImageUrl,
            onImageChanged: handleImageChanged,
          ),
          buildSpace(),
          TextFieldCustom(
            text: "Nombre",
            hintText: "Ingrese nombre",
            controller: _nameController,
            requerido: true,
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
          const Text("Categoria *"),
          const SizedBox(height: 2),
          SelectCustomer(
            options: _listCategory,
            initialValue: initialImageUrl,
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
            requerido: true,
          ),
          buildSpace(),
          TextFieldCustom(
            text: "Tiempo",
            hintText: "Ingrese tiempo",
            controller: _timeController,
            keyboardType: TextInputType.number,
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

  handleCleanText() {
    // Limpiar los campos del formulario
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _timeController.clear();
    _categoryController.text = "seleccione";
    _active = false;
    _prepared = false;
    _listIngredients.clear();
    initialImageUrl = "";
    _image = null;
  }

  handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Obtener los valores del formulario
      String name = _nameController.text;
      String description = _descriptionController.text;
      double price = double.parse(_priceController.text);
      String category = _categoryController.text;
      bool available = _active;
      bool needsPreparation = _prepared;
      int? time;

      if (_timeController.text.isNotEmpty) {
        time = int.tryParse(_timeController.text);
      }

      List<String> ingredients = _listIngredients;
      List<File> image = [_image!];

      try {
        // Crear una instancia de ProductModel
        ProductModel product = ProductModel(
          name: name,
          description: description,
          price: price,
          available: available,
          category: category,
          prepared: needsPreparation,
          ingredients: ingredients,
          time: time,
        );

        // Llamar al método addProduct del ProductsNotifier
        final productAsync = ref.read(productsProvider.notifier);
        await productAsync.addProduct(product, image);
        handleCleanText();
        // Mostrar un mensaje de éxito
        messageDialogSucces(context, "Producto creado exitosamente", "");
      } catch (error) {
        // Mostrar un mensaje de error
        messageDialogError(
          context,
          "Error ${error.toString()}",
          "Error al crear le producto",
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
