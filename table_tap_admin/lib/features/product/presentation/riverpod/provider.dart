// Proveedor para el repositorio
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/product/domain/datasources/remote/firebase_product_repository.dart';
import 'package:table_tap_admin/features/product/infraestructure/reponse/product_response.dart';

final productRepositoryProvider =
    Provider((ref) => FirebaseProductRepository());

// Proveedor para la lista de productos
final productListProvider = StateProvider((ref) {
  final repository = ref.watch(productRepositoryProvider);
});

// Proveedor para un producto específico
final productProvider = FutureProvider.autoDispose
    .family<ProductResponse, String>((ref, productId) {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductById(productId);
});
