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
import 'package:table_tap_admin/features/shared/widgets/image_custom.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/select_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/swich_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textarea_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class ProductEditScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductEditScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ProductEditScreenState();
}

class ProductEditScreenState extends ConsumerState<ProductEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValidationTextForm _validate = ValidationTextForm();

  // variables del formulario
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _timeController = TextEditingController();
  String _imageInit = "";

  bool _active = false;
  bool _prepared = false;
  final List<String> _listIngredients = [];
  final List<CategoryModel> _listCategory = [];
  String _imageUrl = "";

  // variables locales
  bool isLoading = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    handleListcategories();
    handleInitText();
  }

  handleListcategories() async {
    final categoryNotifier = ref.read(categoriesProvider);
    setState(() {
      _listCategory.clear();
      _listCategory.addAll(categoryNotifier.value!);
    });
  }

  handleInitText() {
    final productProvider = ref.read(productsProvider.notifier);
    final product = productProvider.getProductById(widget.productId);

    if (product != null) {
      _nameController.text = product.name;
      _descriptionController.text = product.description;
      _priceController.text = product.price.toString();
      _categoryController.text = product.category;
      _active = product.available;
      _prepared = product.prepared;
      _imageUrl = product.image![0];
      _imageInit = product.image![0];
      _categoryController.text = product.category;
      _listIngredients.clear();
      if (product.ingredients != null && product.ingredients!.isNotEmpty) {
        _listIngredients.addAll(product.ingredients!);
      }
    }
    setState(() {});
  }

  void handleImageChanged(File imageFile) {
    setState(() {
      _image = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar producto"),
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
                const SizedBox(height: 20),
                isLoading ? const LoadingCustomer() : Container(),
                const SizedBox(height: 20),
                ButtonCustomer(text: "guardar", press: handleSubmit),
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
            initialImageUrl: _imageUrl,
            onImageChanged: handleImageChanged,
          ),
          buildSpace(),
          TextFieldCustom(
            text: "Nombre",
            hintText: "Ingrese nombre",
            requerido: true,
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
          const Text("Categoria *"),
          const SizedBox(height: 2),
          if (_categoryController.text.isNotEmpty)
            SelectCustomer(
              options: _listCategory,
              initialValue: _categoryController.text,
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
            requerido: true,
            validator: (value) => _validate.validateLastName(value),
          ),
          buildSpace(),
          TextFieldCustom(
            text: "Tiempo",
            hintText: "Ingrese tiempo",
            controller: _timeController,
            keyboardType: TextInputType.number,
            requerido: true,
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
          if (_listIngredients.isNotEmpty)
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
      ;

      print("url imagen ${_image}");

      // Obtener los valores del formulario
      String name = _nameController.text;
      String description = _descriptionController.text;
      double price = double.parse(_priceController.text);
      String category = _categoryController.text;
      bool available = _active;
      bool needsPreparation = _prepared;
      List<String> ingredients = _listIngredients;
      int? time;

      if (_timeController.text.isNotEmpty) {
        time = int.tryParse(_timeController.text);
      }

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
          image: [_imageInit],
          time: time ?? 0,
        );
        List<File> imagen = [];
        if (_image != null) {
          imagen = [_image!];
        }

        // Llamar al método addProduct del ProductsNotifier
        final productAsync = ref.read(productsProvider.notifier);
        await productAsync.updateProduct(product, widget.productId, imagen);
        // Mostrar un mensaje de éxito
        MessageSnackBar.show(context, "Producto Actualizado con exito");
        //  context.pop();
      } catch (error) {
        // Mostrar un mensaje de error
        MessageSnackBar.show(
            context, "Error al actualizar el producto: ${error.toString()}");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
