// Proveedor para el repositorio
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/restaurant/domain/models/resturantModel.dart';
import 'package:table_tap_admin/features/restaurant/domain/repositories/resturant_repository.dart';
import 'package:table_tap_admin/features/restaurant/infraestructure/datasource/restaurante_datasource_impl.dart';
import 'package:table_tap_admin/features/restaurant/infraestructure/repository/restaurant_repository_impl.dart';
import 'package:table_tap_admin/features/restaurant/presentation/riverpod/restaurant_notifier.dart';

// provedor de repositorios
final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) => RestaurantRepositoryImp(
    restaurantDatasource: RestaurantDatasourceImp(),
  ),
);

// Proveedor para las entidades
final restaurantProvider = StateNotifierProvider<RestaurantNotifier,
    AsyncValue<List<RestaurantModel>>>(
  (ref) => RestaurantNotifier(
    restaurantRepository: ref.read(restaurantRepositoryProvider),
  ),
);
