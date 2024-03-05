import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_add_modal.dart';
import 'package:table_tap_admin/features/product/presentation/widget/category_card.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/users/domain/models/user_model.dart';
import 'package:table_tap_admin/features/users/presentation/widget/user_card.dart';

import '../../riverpod/provider.dart';
import '../../widget/delete_dismissible.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final AsyncValue<List<UserModel>> users = ref.watch(usersProvider).state;

    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: users.when(
        loading: () => const LoadingCustomer(),
        error: (error, stackTrace) => Center(
          child: Text("Error al cargar los usuarios: $error"),
        ),
        data: (users) {
          return users.isEmpty
              ? const Center(
                  child: Text("Lista de usuarios vacía"),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return DeleteDismissible(
                        item: users,
                        onDismissed: (user) {},
                        child: UserCard(user: user));
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorSecondary,
        onPressed: () {
          context.push(RoutesConstants.userAdd);
        },
        child: const Icon(
          Icons.add,
          color: colorPrincipal,
        ),
      ),
    );
  }

  void _handleDelete(BuildContext context, String id) async {
    //  try {
    //    await context.ref(categoriesProvider.notifier).deleteCategory(id);
    //    messageDialogSucces(
    //        context, "La categoría se eliminó con éxito", "Proceso exitoso");
    //  } catch (error) {
    //    messageDialogError(
    //        context, "No se pudo eliminar la categoría", "Ocurrió un error");
    //  }
  }
}
