import 'package:flutter/foundation.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';

final List<CategoryModel> categories = [
  CategoryModel(id: "121", name: 'Comida rapida'),
  CategoryModel(id: "122", name: 'Comida rapida'),
  CategoryModel(id: "123", name: 'Comida rapida'),
  CategoryModel(id: "124", name: 'Comida rapida'),
];

final List<ProductModel> productos = [
  const ProductModel(
      id: '121',
      image: '',
      name: 'Gaseosa',
      description: "description",
      categoryId: "123",
      price: 500,
      prepared: false,
      status: true),
  const ProductModel(
      id: '121',
      image: '',
      name: 'Pizza',
      ingredients: [
        'ingrediente 1',
        'ingrediente 2',
        'ingrediente 3',
        'ingrediente 4'
      ],
      description: "description",
      categoryId: "123",
      price: 500,
      prepared: true,
      status: true),
];
