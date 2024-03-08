import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/restaurant/presentation/riverpod/riverpod.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/details_screen.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/register_res_screen.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantState = ref.watch(restaurantProvider);
    return restaurantState.when(
      loading: () => const Center(
        child: LoadingCustomer(),
      ),
      error: (error, stackTrace) => Center(
        child: Text("Error al cargar restaurante: $error"),
      ),
      data: (restaurant) {
        if (restaurant == null || restaurant.isEmpty) {
          return RegisterResScreen();
        } else {
          return const DetailsRestScreen();
        }
      },
    );
  }
}
